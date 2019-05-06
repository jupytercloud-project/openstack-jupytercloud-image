#!/usr/bin/env bash

set -x

packer_project="$(dirname ${BASH_SOURCE})"
image_name_base="$(basename ${packer_project})"

function ::Packer.build() {
  #PACKER_LOG_PATH=${packer_log_path} \
  curl --location \
       --output cacert.pem \
       "${OS_CACERT}"
  PACKER_LOG=1 \
  packer build \
    ${packer_project}/config-openstack.json
}

function ::Main () {
  ::Packer.build
}

::Main
