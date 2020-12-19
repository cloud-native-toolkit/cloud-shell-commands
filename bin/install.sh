#!/bin/bash

VERSION=$(curl --silent "https://api.github.com/repos/ibm-garage-cloud/cloud-shell-commands/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')

URL="https://github.com/ibm-garage-cloud/cloud-shell-commands/releases/download/${VERSION}/assets.tar.gz"

echo "Downloading scripts gzip: ${URL}"
curl -sSL -o assets.tar.gz "${URL}"

SCRIPT_DIR="${PWD}/tmp"

mkdir "${SCRIPT_DIR}"
cd "${SCRIPT_DIR}"
tar xzf ../assets.tar.gz
rm ../assets.tar.gz

mkdir ~/bin
cd ~/bin

echo "Installing argocd cli"
"${SCRIPT_DIR}/install-argocd"

echo "Installing igc cli"
"${SCRIPT_DIR}/install-igc"

echo "Installing tkn cli"
"${SCRIPT_DIR}/install-tkn"

echo "Setting up cmd with kube-ps1"
"${SCRIPT_DIR}/install-kube-ps1-bash"
"${SCRIPT_DIR}/install-kube-ps1-zsh"

echo "Setting up icc"
cp "${SCRIPT_DIR}/icc" .

rm -rf "${SCRIPT_DIR}"

echo "export PATH='${PATH}:~/bin'" >> ~/.bashrc
echo "export PATH='${PATH}:~/bin'" >> ~/.zshrc
