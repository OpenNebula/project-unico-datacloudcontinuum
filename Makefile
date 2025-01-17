include Makefile.config
-include Makefile.local

check:
	ansible --version
	terraform --version

dependencies_deploy:
	git submodule init && git submodule update
	cd ${ONE_DEPLOY} && make requirements

opennebula:
	[[ -d ${ONE_DEPLOY}/ansible_collections/community/general/ ]] || make dependencies_deploy
	cd ansible && echo "$${ONE_DEPLOY_INVENTORY}" > inventory.yaml
	cd ansible && ansible-playbook playbooks/dcc.yaml -i inventory.yaml

content:
	cd terraform && echo "$${TERRAFORM_VARS}" > terraform.tfvars
	cd terraform && terraform apply

clean:
	cd terraform && terraform destroy

dcc:
	make opennebula content

debug:
	@echo "$${ONE_DEPLOY_INVENTORY}"
	@echo "$${TERRAFORM_VARS}"
