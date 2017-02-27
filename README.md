# docker-deployment

- Requires new [BOSH CLI v2.0.1+](https://github.com/cloudfoundry/bosh-cli)

```
$ rm -f creds.yml

$ bosh create-env docker.yml \
  --state ./state.json \
  -o ./virtualbox/cpi.yml \
  -o ./virtualbox/outbound-network.yml \
  -o jumpbox-user.yml \
  --vars-store ./creds.yml \
  -v internal_ip=192.168.50.8 \
  -v internal_gw=192.168.50.1 \
  -v internal_cidr=192.168.50.1/24 \
  -v outbound_network_name=NatNetwork
```

Connect to Docker from the host (mutual TLS):

```
$ export DOCKER_TLS_VERIFY=true
$ export DOCKER_HOST=tcp://192.168.50.8:4243
$ bosh int creds.yml --path /docker_client_ssl/ca > ~/.docker/ca.pem
$ bosh int creds.yml --path /docker_client_ssl/certificate > ~/.docker/cert.pem
$ bosh int creds.yml --path /docker_client_ssl/private_key > ~/.docker/key.pem
$ docker images
```

Example with VirtualBox shared folders:

```
$ bosh create-env docker.yml \
  --state ./state.json \
  -o ./virtualbox/cpi.yml \
  -o ./virtualbox/outbound-network.yml \
  -o ./virtualbox/shared-folders.yml \
  -o jumpbox-user.yml \
  --vars-store ./creds.yml \
  -v internal_ip=192.168.50.8 \
  -v internal_gw=192.168.50.1 \
  -v internal_cidr=192.168.50.1/24 \
  -v outbound_network_name=NatNetwork \
  -v shared_from=/tmp/foo \
  -v shared_to=/tmp/foo
```
