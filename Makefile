.PHONY: default tffmt tfplan tfapply tfrefresh tftaint tfoutput tfdestroy ssh galaxy setup deploy

default: tfapply setup deploy

tffmt:
	cd provisioning/terraform && terraform fmt

tfplan:
	cd provisioning/terraform && terraform init && terraform plan

tfapply:
	cd provisioning/terraform && terraform init && terraform apply

tfrefresh:
	cd provisioning/terraform && terraform init && terraform refresh

tftaint:
	cd provisioning/terraform && terraform init && terraform taint $(R)

tfoutput:
	cd provisioning/terraform && terraform init && terraform output

tfdestroy:
	cd provisioning/terraform && terraform init && terraform destroy

ssh:
	@my_instance_ip=$$(cd provisioning/terraform && terraform output -no-color public_ip) \
	&& ssh ubuntu@$$my_instance_ip

galaxy:
	cd provisioning/ansible && ansible-galaxy install -r requirements.yml -p roles/

setup:
	my_instance_ip=$$(cd provisioning/terraform && terraform output -no-color public_ip) \
	&& cd provisioning/ansible \
	&& ansible-playbook \
		-i hosts \
		--extra-vars "my_instance_ip=$$my_instance_ip" \
		main.yml

deploy:
	my_instance_ip=$$(cd provisioning/terraform && terraform output -no-color public_ip) \
	&& cd provisioning/ansible \
	&& ansible-playbook \
		-i hosts \
		--extra-vars "my_instance_ip=$$my_instance_ip" \
		deploy.yml
