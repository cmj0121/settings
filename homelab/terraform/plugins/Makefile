ENV := .env

.PHONY: all clean test plan build output destroy help $(ENV)

all: 			# default action
	terragrunt init -upgrade -reconfigure

clean:			# clean-up environment

test:			# run test

plan:			# plan the environment without applying
	@echo terragrunt plan
	@$(shell cat $(ENV) | xargs) terragrunt plan

build:			# apply the environment without asking
	@echo terragrunt apply -auto-approve
	@$(shell cat $(ENV) | xargs) terragrunt apply -auto-approve

output:			# show the output
	@echo terragrunt output -json
	@$(shell cat $(ENV) | xargs) terragrunt output -json

destroy:		# destroy the environment
	@echo terragrunt destroy
	@$(shell cat $(ENV) | xargs) terragrunt destroy

help:			# show this message
	@printf "Usage: make [OPTION]\n"
	@printf "\n"
	@perl -nle 'print $$& if m{^[\w-]+:.*?#.*$$}' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?#"} {printf "    %-18s %s\n", $$1, $$2}'

plan build output destroy: $(ENV)
$(ENV):
	@$(MAKE) -C ../modules/services/ output | tail -n +2 | jq -r 'to_entries[] | "TF_VAR_\(.key)=\(.value.value)"' > $@
