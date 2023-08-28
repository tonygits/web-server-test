.PHONY: init
init:
	@cd terraform && terraform init
	@cp terraform/staging.tfvars.sample terraform/staging.tfvars

.PHONY: plan
plan:
	@cd terraform && terraform plan -var-file="staging.tfvars"

.PHONY: apply
apply:
	@cd terraform && terraform apply -auto-approve -var-file="staging.tfvars"

.PHONY: destroy
destroy:
	@cd terraform && terraform destroy -var-file="staging.tfvars"