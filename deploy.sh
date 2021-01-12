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