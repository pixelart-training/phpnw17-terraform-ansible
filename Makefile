.PHONY: tffmt tfplan tfapply tfrefresh tfoutput tfdestroy ssh

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
