.PHONY: all clean test plan build output output-json destroy help

all: 			# default action
	terragrunt init -upgrade -reconfigure

clean:			# clean-up environment

test:			# run test

plan:			# plan the environment without applying
	terragrunt plan

build:			# apply the environment without asking
	terragrunt apply -auto-approve

output:			# show the output
	terragrunt output

output-json:	# show the output with JSON format
	terragrunt output -json

destroy:		# destroy the environment
	terragrunt destroy

help:			# show this message
	@printf "Usage: make [OPTION]\n"
	@printf "\n"
	@perl -nle 'print $$& if m{^[\w-]+:.*?#.*$$}' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?#"} {printf "    %-18s %s\n", $$1, $$2}'
