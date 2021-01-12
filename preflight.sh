#!/bin/bash

## set -x	## Uncomment for debugging

## Setting path so that we can automatically pull in needed binaries
export PATH="$HOME/.local/bin:$PATH"

## Include vars if the file exists
FILE=./vars.sh
if [ -f "$FILE" ]; then
    source ./vars.sh
else
    echo "Need to generate variable file first"
    exit 1
fi

## Functions
function checkForProgram() {
    command -v $1
    if [[ $? -eq 0 ]]; then
        printf '%-72s %-7s\n' $1 "PASSED!";
    else
        printf '%-72s %-7s\n' $1 "FAILED!";
    fi
}
function checkForProgramAndExit() {
    command -v $1
    if [[ $? -eq 0 ]]; then
        printf '%-72s %-7s\n' $1 "PASSED!";
    else
        printf '%-72s %-7s\n' $1 "FAILED!";
        exit 1
    fi
}
function checkForProgramAndInstallLocal() {
    command -v $1
    if [[ $? -eq 0 ]]; then
        printf '%-72s %-7s\n' $1 "PASSED!";
    else
        printf '%-72s %-7s\n' $1 "FAILED! INSTALLING NOW...";
        mkdir -p $HOME/.local/bin/

        case $1 in
          terraform)
            curl -sL -o terraform.zip ${TERRAFORM_URL}
            unzip terraform.zip
            chmod +x terraform
            mv terraform $HOME/.local/bin/terraform
            rm terraform.zip
            ;;

          fcct)
            curl -sL -o $HOME/.local/bin/fcct ${FCCT_URL}
            chmod +x $HOME/.local/bin/fcct
            ;;

          govc)
            curl -sL -o govc.gz ${GOVC_URL}
            gzip -dc govc.gz > $HOME/.local/bin/govc
            chmod +x $HOME/.local/bin/govc
            rm govc.gz
            ;;

          oc)
            curl -sL -o $HOME/.local/bin/oc.tar.gz ${OPENSHIFT_CLIENT_URL}
            tar zxf $HOME/.local/bin/oc.tar.gz -C $HOME/.local/bin/
            chmod +x $HOME/.local/bin/oc
            chmod +x $HOME/.local/bin/kubectl
            rm $HOME/.local/bin/oc.tar.gz
            ;;

          openshift-install)
            curl -sL -o $HOME/.local/bin/openshift-install.tar.gz ${OPENSHIFT_INSTALLER_URL}
            tar zxf $HOME/.local/bin/openshift-install.tar.gz -C $HOME/.local/bin/
            chmod +x $HOME/.local/bin/openshift-install
            rm $HOME/.local/bin/openshift-install.tar.gz
            ;;

          *)
            echo -n "unknown app"
            ;;
        esac
    fi
}

## Check needed binaries are installed
checkForProgramAndExit curl
checkForProgramAndExit jq
checkForProgramAndExit unzip
checkForProgramAndInstallLocal terraform
checkForProgramAndInstallLocal govc
checkForProgramAndInstallLocal fcct

checkForProgramAndInstallLocal oc
checkForProgramAndInstallLocal openshift-install

## Pull assets
. ./scripts/pull-ova.sh

cd infra

## Initialize Terraform
terraform init

## Do an initial plan as a test
terraform plan

if [[ $? -eq 0 ]]; then
  echo ""
  echo "============================================================================"
  echo " READY!!!"
  echo "============================================================================"
  echo ""
  echo "Next, just run './deploy.sh' to deploy the cluster!"
  echo ""
else
  echo ""
  echo "============================================================================"
  echo " FAILED!!!"
  echo "============================================================================"
  echo ""
  echo "There seem to be issues with planning out the terraform deployment"
  echo ""
fi