#!/bin/bash

mkdir -p ${WORKING_DIRECTORY}/cache/

if [ ! -f ${WORKING_DIRECTORY}/cache/rhcos-${OCP_VERSION}-vmware.x86_64.ova ]; then
  echo "Pulling ${RHCOS_OVA_URL}"
  curl -L -o ${WORKING_DIRECTORY}/cache/rhcos-${OCP_VERSION}-vmware.x86_64.ova ${RHCOS_OVA_URL}
fi