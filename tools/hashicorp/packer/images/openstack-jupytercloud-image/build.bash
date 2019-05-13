#!/usr/bin/env bash

set -x

packer_project="$(dirname ${BASH_SOURCE})"
image_name_base="$(basename ${packer_project})"

function ::CACert.fetch() {
  curl --output ./cacert.pem \
       --location "${OS_CACERT}"
}

function ::Image.upload() {
  openstack --version
  #
  # make it work even with openstack installation without http image source
  #
  curl --output openstack-alpine-image-3.9.3.raw \
       --location "${SRC}"
  openstack --os-cacert ./cacert.pem \
            --os-image-api-version 2 \
            image create \
            --file ./openstack-alpine-image-3.9.3.raw \
            openstack-alpine-image-3.9.3
}

function ::Packer.build() {
  #PACKER_LOG_PATH=${packer_log_path} \
  PACKER_LOG=1 \
  packer build \
    ${packer_project}/config-openstack.json
}

function ::Main () {
  ::CACert.fetch
  ::Image.upload
  ::Packer.build
}

::Main
