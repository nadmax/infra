.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

## Initial infrastructure setup
setup: apply configure

## See infrastructure changes
plan:
	cd tofu && terraform plan

## Apply infrastructure changes
apply:
	cd tofu && terraform apply

## Configure VPS with Ansible
config:
	cd ansible && ansible-playbook playbook.yml -i inventory.ini

## Check cluster status
status:
	kubectl get nodes
	kubectl get pods -A

## Destroy everything
destroy:
	cd tofu && tofu destroy
