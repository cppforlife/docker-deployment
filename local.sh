#!/bin/bash

set -e

# rm -f ./creds.yml

bosh create-env docker.yml \
  --state ./state.json \
  -o ./virtualbox/cpi.yml \
  -o ./virtualbox/outbound-network.yml \
  -o jumpbox-user.yml \
  -o cluster.yml \
  --vars-store ./creds.yml \
  -v internal_ip=192.168.50.8 \
  -v internal_gw=192.168.50.1 \
  -v internal_cidr=192.168.50.1/24 \
  -v outbound_network_name=NatNetwork
