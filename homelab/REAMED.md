# Home Lab

> ~ Set up a home lab ~

## Playbooks

The **playbooks** is the basic physical infrastructure of the lab. It sets up the
physical machines, the network, and the necessary software to run the lab.

You can change the inventory file **playbooks/inventory.ini** to match your own setup.

### MacOS

You can setup the lab on MacOS by the [multipass][0] provider. You need to install
multipass by homebrew `brew --cask install multipass`. After launching the lab, you
have to set up the ssh keys for the machines. You can do this by running the
following script:

```bash
#! /usr/bin/env bash

NAME=homelab

function check_command() {
	if ! command multipass -h >/dev/null 2>&1; then
		echo "[!] multipass is not installed ..."
		exit 1
	fi
}

function lauch_instance() {
	INSTANCE_NAME="$1"

	multipass launch --name "$INSTANCE_NAME"
	show_instance "$INSTANCE_NAME"
}

function setup_ssh_key() {
	if [ -f "$HOME/.ssh/id_ed25519" ]; then
		# already exists the SSH private key
		return
	fi

	ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519" -P ""
}

function setup_instance() {
	INSTANCE_NAME="$1"

	if ! multipass info "$INSTANCE_NAME" 2>/dev/null; then
		echo "[-] Instance $INSTANCE_NAME not exists, launch new one ..."
		lauch_instance "$1"
	fi

	echo "[+] Setup instance $INSTANCE_NAME ..."
	setup_ssh_key

	{
		cat "$HOME/.ssh/id_ed25519.pub"
	} | multipass exec "$INSTANCE_NAME" -- bash -c "cat >> ~/.ssh/authorized_keys"

	echo "[+] Done"
	echo "[+] You can connect to the instance by: ssh ubuntu@$(multipass info "$INSTANCE_NAME" | grep IPv4 | awk '{print $2}')"
}

function main() {
	check_command
	setup_instance "$1"
}

main "$NAME"
```

, and you can add the target machine to the inventory file inside the **playbooks/inventory**

[0]: https://multipass.run/
