#!/usr/bin/env bash

set -x

function ::Packer.build() {
  #PACKER_LOG_PATH=${packer_log_path} \
  PACKER_LOG=1 \
  packer build \
    -var-file ${packer_project}/run/release.json \
    ${packer_project}/config-openstack.json \
}

function ::Main () {
  ::Packer.build
}

::Main
