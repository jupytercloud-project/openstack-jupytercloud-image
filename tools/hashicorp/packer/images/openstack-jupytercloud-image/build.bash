#!/usr/bin/env bash

set -x

packer_project="$(dirname ${BASH_SOURCE})"
image_name_base="$(basename ${packer_project})"

function ::Packer.build() {
  #PACKER_LOG_PATH=${packer_log_path} \
  PACKER_LOG=1 \
  packer build \
    -var "openstack_identity_endpoint=${OPENSTACK_IDENTITY_ENDPOINT}" \
    -var "openstack_domain_name=${OPENSTACK_DOMAIN_NAME}" \
    -var "openstack_tenant_name=${OPENSTACK_TENANT_NAME}" \
    -var "openstack_username=${OPENSTACK_USERNAME}" \
    -var "openstack_password=${OPENSTACK_PASSWORD}" \
    ${packer_project}/config-openstack.json
}

function ::Main () {
  ::Packer.build
}

::Main
