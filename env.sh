export ARCH="amd64"
export K8S_VERSION=""
export KUBE_RELEASE_VERSION=""
export CNI_PLUGINS_VERSION=""
# make sure the file cri-containerd-${CONTAINERD_VERSION}-linux-${ARCH}.tar.gz exists
export CONTAINERD_VERSION="1.6.8"

export IMAGE_REPO="registry.cn-hangzhou.aliyuncs.com/google_containers"

export PACK_DIR="packdir"
export BIN_DIR="/usr/local/bin"
export CNI_DEST_DIR="/opt/cni/bin"

# default vaue
[ ! -z "$ARCH" ] || export ARCH=$(uname -m)
[ ! -z "$K8S_VERSION" ] || export K8S_VERSION="$(curl -sSL https://dl.k8s.io/release/stable.txt)"
[ ! -z "$KUBE_RELEASE_VERSION" ] || export KUBE_RELEASE_VERSION=$(curl -s https://api.github.com/repos/kubernetes/release/releases/latest | grep tag_name|cut -f4 -d "\"")
[ ! -z "$CNI_PLUGINS_VERSION" ] || export CNI_PLUGINS_VERSION=$(curl -s https://api.github.com/repos/containernetworking/plugins/releases/latest | grep tag_name|cut -f4 -d "\"")
# make sure the file cri-containerd-${CONTAINERD_VERSION}-linux-${ARCH}.tar.gz exists
#[ ! -z "$CONTAINERD_VERSION" ] || export CONTAINERD_VERSION=$(curl -s https://api.github.com/repos/containerd/containerd/releases/latest | grep tag_name|cut -f4 -d "\"")



