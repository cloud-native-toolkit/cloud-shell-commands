#!/bin/bash

VERSION=$(curl --silent "https://api.github.com/repos/ibm-garage-cloud/cloud-shell-commands/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
URL="https://github.com/ibm-garage-cloud/cloud-shell-commands/releases/download/${VERSION}/assets.tar.gz"

echo "Downloading scripts: ${URL}"
curl -sSL -o assets.tar.gz "${URL}"

SCRIPT_DIR="${PWD}/tmp"

mkdir -p "${SCRIPT_DIR}"
cd "${SCRIPT_DIR}"
tar xzf ../assets.tar.gz
rm ../assets.tar.gz

mkdir -p ~/bin
cd ~/bin

echo "** Installing argocd cli"
"${SCRIPT_DIR}/install-argocd"

echo "** Installing tkn cli"
"${SCRIPT_DIR}/install-tkn"

echo "** Installing kube-ps1"
"${SCRIPT_DIR}/install-kube-ps1-bash"
"${SCRIPT_DIR}/install-kube-ps1-zsh"

echo "** Installing icc"
cp "${SCRIPT_DIR}/icc" .

echo "** Installing Cloud-Native Toolkit cli"
"${SCRIPT_DIR}/install-igc"

rm -rf "${SCRIPT_DIR}"

if [[ "${SHELL}" =~ zsh ]]; then
  echo "export PATH='~/bin:${PATH}'" >> ~/.zshrc
else
  echo "export PATH='~/bin:${PATH}'" >> ~/.bashrc
fi
