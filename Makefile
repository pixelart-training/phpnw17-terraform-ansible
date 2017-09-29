.PHONY: tffmt tfplan tfapply tfrefresh tfoutput tfdestroy ssh setup

tffmt:
	cd provisioning/terraform && terraform fmt

tfplan:
	cd provisioning/terraform && terraform init && terraform plan

tfapply:
	cd provisioning/terraform && terraform init && terraform apply

tfrefresh:
	cd provisioning/terraform && terraform init && terraform refresh

tfoutput:
	cd provisioning/terraform && terraform init && terraform output

tfdestroy:
	cd provisioning/terraform && terraform init && terraform destroy

ssh:
	@my_instance_ip=$$(cd provisioning/terraform && terraform output -no-color public_ip) \
	&& ssh ubuntu@$$my_instance_ip

setup:
	my_instance_ip=$$(cd provisioning/terraform && terraform output -no-color public_ip) \
	&& cd provisioning/ansible \
	&& ansible-playbook \
		-i hosts \
		--extra-vars "my_instance_ip=$$my_instance_ip" \
		main.yml
