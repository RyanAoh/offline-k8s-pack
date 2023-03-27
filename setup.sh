ARCH=$ARCH
K8S_VERSION=$K8S_VERSION
KUBE_RELEASE_VERSION=$KUBE_RELEASE_VERSION
CNI_PLUGINS_VERSION=$CNI_PLUGINS_VERSION
CONTAINERD_VERSION=$CONTAINERD_VERSION
IMAGE_REPO=$IMAGE_REPO
BIN_DIR=$BIN_DIR
CNI_DEST_DIR=$CNI_DEST_DIR

set -ue

mkdir -p ${BIN_DIR}

echo "install kube file"
cp {kubectl,kubelet,kubeadm} ${BIN_DIR}
cat kubelet.service | sed "s:/usr/bin:${BIN_DIR}:g" | sudo tee /etc/systemd/system/kubelet.service
sudo mkdir -p /etc/systemd/system/kubelet.service.d
cat 10-kubeadm.conf | sed "s:/usr/bin:${BIN_DIR}:g" | sudo tee /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
systemctl enable --now kubelet

echo "install cni plugins"
mkdir -p ${CNI_DEST_DIR}
sudo tar -C ${CNI_DEST_DIR} -xzf cni-plugins-linux-${ARCH}-${CNI_PLUGINS_VERSION}.tgz

echo "install containerd"
tar -C /  -xzf cri-containerd-${CONTAINERD_VERSION}-linux-${ARCH}.tar.gz
mkdir -p /etc/containerd
containerd config default > /etc/containerd/config.toml
sed -i "s%\".*/pause.*\"%\"$(kubeadm config images list --config kubeadm-config.yaml | grep pause)\"%g" /etc/containerd/config.toml
systemctl enable --now containerd

echo "import images"
ls images | xargs -I{} bash -c "ctr -n k8s.io i import images/{}"

yum install -y conntrack libseccomp

modprobe br_netfilter
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.bridge.bridge-nf-call-iptables=1

kubeadm init --config kubeadm-config.yaml

set +ue
