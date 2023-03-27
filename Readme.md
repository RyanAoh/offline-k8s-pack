## Overview
Quickly create an installation package that contains all the necessary files for deploying k8s. This installation package can be used to deploy a cluster in an offline environment with just one click.

## Usage
### 1. custom config
Set version variables in the env.sh.

You can also custom the config for kubeadm by edit the default kubeadm-config.yaml

### 2. make package
Requirement
 + install makeself && containerd on the host

Make okp-$K8S_VERSION.run file:
```shell
git clone https://github.com/RyanAoh/offline-k8s-pack
cd offline-k8s-pack
./pack.sh
```

### 3. deploy k8s
Copy okp-$K8S_VERSION.run to you hosts which are used to deploy k8s. Then run as follow:
```shell
./okp-$K8S_VERSION.run
```
