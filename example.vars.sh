#!/bin/bash

VSPHERE_USER="administrator@vmware.com"
VSPHERE_PASS="sup3rS3cr3t"
VSPHERE_FQDN="vcenter.example.com"

OCP_CHANNEL="stable"
OCP_VERSION="4.6"

TERRAFORM_VERSION="0.14.4"
FCCT_VERSION="0.8.0"
GOVC_VERSION="0.24.0"

WORKING_DIRECTORY="$HOME/.generated"
mkdir -p $WORKING_DIRECTORY

############################################################################################################
## DO NOT EDIT PAST THIS LINE!

function getOSSlug() {
  unameOut="$(uname -s)"
  case "${unameOut}" in
      Linux*)     machine=linux;;
      Darwin*)    machine=darwin;;
      CYGWIN*)    machine=windows;;
      MINGW*)     machine=MinGw;;
      *)          machine="UNKNOWN:${unameOut}"
  esac
  echo ${machine}
}

function getOSMajor() {
  unameOut="$(uname -s)"
  case "${unameOut}" in
      Linux*)     machine=linux;;
      Darwin*)    machine=mac;;
      CYGWIN*)    machine=windows;;
      MINGW*)     machine=MinGw;;
      *)          machine="UNKNOWN:${unameOut}"
  esac
  echo ${machine}
}

function getOSManSlug() {
  unameOut="$(uname -s)"
  case "${unameOut}" in
      Linux*)     machine=unknown;;
      Darwin*)    machine=apple;;
      CYGWIN*)    machine=pc;;
      MINGW*)     machine=unknown;;
      *)          machine="UNKNOWN:${unameOut}"
  esac
  echo ${machine}
}

export TF_VAR_vsphere_user=$VSPHERE_USER
export TF_VAR_vsphere_password=$VSPHERE_PASS
export TF_VAR_vsphere_server=$VSPHERE_FQDN

export GOVC_URL="https://github.com/vmware/govmomi/releases/download/v${GOVC_VERSION}/govc_$(getOSSlug)_amd64.gz"
export TERRAFORM_URL="https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_$(getOSSlug)_amd64.zip"
export FCCT_URL="https://github.com/coreos/fcct/releases/download/v${FCCT_VERSION}/fcct-x86_64-$(getOSSlug)-$(getOSSlug)"

export OPENSHIFT_BASE_URL="https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/${OCP_CHANNEL}-${OCP_VERSION}"
export OPENSHIFT_CLIENT_URL="${OPENSHIFT_BASE_URL}/$(curl -sL ${OPENSHIFT_BASE_URL}/sha256sum.txt | cut -d ' ' -f 3 | grep openshift-client-$(getOSMajor))"
export OPENSHIFT_INSTALLER_URL="${OPENSHIFT_BASE_URL}/$(curl -sL ${OPENSHIFT_BASE_URL}/sha256sum.txt | cut -d ' ' -f 3 | grep openshift-install-$(getOSMajor))"

export RHCOS_BASE_URL="https://mirror.openshift.com/pub/openshift-v4/x86_64/dependencies/rhcos/${OCP_VERSION}/latest"
export RHCOS_OVA_URL="${RHCOS_BASE_URL}/$(curl -sL ${RHCOS_BASE_URL}/sha256sum.txt | cut -d ' ' -f 3 | grep rhcos-${OCP_VERSION} | grep vmware)"