#!/bin/bash

VERSION=$(curl --silent "https://api.github.com/repos/ibm-garage-cloud/cloud-shell-commands/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
curl -sSL -o assets.tar.gz "https://github.com/ibm-garage-cloud/cloud-shell-commands/releases/download/${VERSION}/assets.tar.gz"

SCRIPT_DIR="${PWD}/tmp"

mkdir "${SCRIPT_DIR}"
cd "${SCRIPT_DIR}"
tar xzf ../assets.tar.gz
rm ../assets.tar.gz

mkdir ~/bin
cd ~/bin

"${SCRIPT_DIR}/install-argocd"
"${SCRIPT_DIR}/install-igc"
"${SCRIPT_DIR}/install-tkn"
"${SCRIPT_DIR}/install-kube-ps1-bash"
"${SCRIPT_DIR}/install-kube-ps1-zsh"

cp "${SCRIPT_DIR}/icc" .

rm -rf "${SCRIPT_DIR}"

echo "export PATH='${PATH}:~/bin'" >> ~/.bashrc
echo "export PATH='${PATH}:~/bin'" >> ~/.zshrc
