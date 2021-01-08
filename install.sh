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

if ! command -v jq > /dev/null; then
  echo "** Installing jq"
  "${SCRIPT_DIR}/install-jq"
fi

if ! command -v oc > /dev/null; then
  echo "** Installing oc cli"
  "${SCRIPT_DIR}/install-oc"
fi

if ! command -v argocd > /dev/null; then
  echo "** Installing argocd cli"
  "${SCRIPT_DIR}/install-argocd"
fi

if ! command -v tkn > /dev/null; then
  echo "** Installing tkn cli"
  "${SCRIPT_DIR}/install-tkn"
fi

if ! command -v ibmcloud > /dev/null; then
  echo "** Installing ibmcloud cli"
  curl -sL https://ibm.biz/idt-installer | bash
fi

if ! command -v kube-ps1.sh > /dev/null; then
  echo "** Installing kube-ps1"
  "${SCRIPT_DIR}/install-kube-ps1-bash"
  "${SCRIPT_DIR}/install-kube-ps1-zsh"
fi

if ! command -v icc > /dev/null; then
  echo "** Installing icc"
  cp "${SCRIPT_DIR}/icc" .
fi

if ! command -v igc > /dev/null; then
  echo "** Installing Cloud-Native Toolkit cli"
  "${SCRIPT_DIR}/install-igc"
fi

rm -rf "${SCRIPT_DIR}"

if [[ "${SHELL}" =~ zsh ]]; then
  if ! grep -qE 'export PATH=.*${HOME}/bin' ~/.zshrc; then
    echo 'export PATH="${HOME}/bin:${PATH}"' >> ~/.zshrc
  fi
else
  if ! grep -qE 'export PATH=.*${HOME}/bin' ~/.bashrc; then
    echo 'export PATH="${HOME}/bin:${PATH}"' >> ~/.bashrc
  fi
fi
