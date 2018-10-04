#!/bin/bash

set -e

# This file has the full flexibility of any program. This can perform gpg
# decryption, interact with a key management service, and more. It is
# intentionally complex in this example to show off multiple ways to provide
# the vault password.


## Walking through the options:
if [[ -r .vault_password ]]; then
  # First, we can merely read a password from a plaintext file that was perhaps
  # shipped with this repository.
  cat .vault_password
elif [[ $(which gpg 2>/dev/null) && -r .vault_password.asc ]]; then
  # Second, if GPG is present and there's a GPG encrypted (armoured) password
  # file let's try to decrypt it.
  gpg -d .vault_password.asc 2>/dev/null
elif [[ $(which gcloud 2>/dev/null) && -r $HOME/.config/gcloud/configurations/confg_default ]]; then
  # Third, perhaps we've configured the gcloud utility provided by Google for
  # its Google Cloud Platform and can try to decrypt a password from an
  # encrypted file with a key stored in Google's KMS product.
  gcloud kms decrypt \
    --location="${ANSIBLE_KMS_LOC:-global}" \
    --keyring="${ANSIBLE_KMS_KEYRING:-vault_keyring}" \
    --key="${ANSIBLE_KMS_KEY:-private_key}" \
    --ciphertext-file=.vault_password.enc \
    --plaintext-file=-
elif [[ $(which docker 2>/dev/null) && -r .docker_vault_image && -d $HOME/.demo_vault_keydir ]]; then
  # Fourth, perhaps the use case is that we have provivionsed developer
  # workstations with a special set of credentials that live in their home
  # directory in a place, in this example, called .demo_vault_keydir. Maybe
  # we also specify a special Docker image with this repository that treats
  # the contents of the .demo_vault_keydir directory as a cryptographic 
  # "challenge" and provides the "response" as the password to unlock the vault.
  docker run -v $HOME/.demo_vault_keydir:/etc/unlocking_keys $(cat .docker_vault_image) -- python /opt/vaultdecryption.py -c /etc/unlocking_keys
else
  # Finally, since it is the author's hope that none of the previous conditions
  # have been met the demo password is provided.
  echo "full password"
fi