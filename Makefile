.PHONY: tffmt tfplan tfapply tfdestroy

tffmt:
	cd provisioning/terraform && terraform fmt

tfplan:
	cd provisioning/terraform && terraform init && terraform plan

tfapply:
	cd provisioning/terraform && terraform init && terraform apply

tfdestroy:
	cd provisioning/terraform && terraform init && terraform destroy
