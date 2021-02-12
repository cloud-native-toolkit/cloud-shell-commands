#!/bin/bash

VERSION=$(curl --silent "https://api.github.com/repos/ibm-garage-cloud/cloud-shell-commands/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
URL="https://github.com/ibm-garage-cloud/cloud-shell-commands/releases/download/${VERSION}/assets.tar.gz"

echo "Downloading scripts: ${URL}"
curl -sSL -o assets.tar.gz "${URL}"

SCRIPT_DIR="${PWD}/tmp"

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

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

echo ""
echo -e "${GREEN}kube-ps1${NC} has been installed to display the current Kubernetes context and namespace in the prompt. It can be turned on and off with the following commands:"
echo ""
echo -e "  ${YELLOW}kubeon${NC}     - turns kube-ps1 on for the current session"
echo -e "  ${YELLOW}kubeon -g${NC}  - turns kube-ps1 on globally"
echo -e "  ${YELLOW}kubeoff${NC}    - turns kube-ps1 off for the current session"
echo -e "  ${YELLOW}kubeoff -g${NC} - turns kube-ps1 off globally"
echo ""

if [[ "${SHELL}" =~ zsh ]]; then
  if ! grep -qE 'export PATH=.*${HOME}/bin' ~/.zshrc; then
    echo 'export PATH="${HOME}/bin:${PATH}"' >> ~/.zshrc
  fi

  echo "Your shell configuration has been updated. Run the following to apply the changes to the current terminal:"
  echo ""
  echo -e "  ${YELLOW}source ~/.zshrc${NC}"
else
  if ! grep -qE 'export PATH=.*${HOME}/bin' ~/.bashrc; then
    echo 'export PATH="${HOME}/bin:${PATH}"' >> ~/.bashrc
  fi

  echo "Your shell configuration has been updated. Run the following to apply the changes to the current terminal:"
  echo ""
  echo -e "  ${YELLOW}source ~/.bashrc${NC}"
fi

echo ""
