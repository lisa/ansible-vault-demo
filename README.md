# Ansible Vault Demo

Simple demo around Ansible Vault showing three ways to use Vault with a variety for decryption.


# Who is this for?

This repository serves as an introduction for readers who are familiar with Ansible but may not be as familiar with [Ansible Vault][1] method to encrypt secrets. Hashicorp has a product with the name [Vault][5] that is unrelated to this demo.

# About the implementation

The implementations are minimal in order to focus on Ansible Vault. The demo encrypts data in three ways:

1. A full file that's encrypted ([full\_file][2])
2. A full YAML file containing key-value pairs ([full\_yaml][3])
3. A single encrypted key-value pair in a YAML document containing other plain text key-value pairs ([partial\_yaml][4])

Each of these roles will write a file to the [output][6] directory. The written file will contain the plain text representation of the encrypted data.

## Pieces of the Puzzle

This demo comes with an `ansible.cfg` that will instruct Ansible to use a shell script ([decrypt\_password.sh][7]) to provide the password to unlock the vault. The contents of the shell script can do any kind of logic and includes some ideas. Some of the ideas to provide the vault password include using gpg to decrypt a file, using a key management service (eg Google KMS) to assist in decrypting an encrypted file containing the vault password, and so on.

# Running the demo

Clone the repository and run with: `./run_demo.sh`. Or build and run with Docker:

    docker build -t ansible-demo -f Dockerfile .
    docker run ansible-demo


[1]: https://docs.ansible.com/ansible/2.6/user_guide/vault.html
[2]: roles/full_file
[3]: roles/full_yaml
[4]: roles/partial_yaml
[5]: https://vaultproject.io
[6]: output
[7]: decrypt_password.sh