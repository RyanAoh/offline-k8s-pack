#source env.sh

set -uex

cd $1

wget -q https://dl.k8s.io/release/${K8S_VERSION}/bin/linux/${ARCH}/{kubeadm,kubelet,kubectl}
chmod +x {kubeadm,kubelet,kubectl}

wget -q "https://raw.githubusercontent.com/kubernetes/release/${KUBE_RELEASE_VERSION}/cmd/kubepkg/templates/latest/deb/kubelet/lib/systemd/system/kubelet.service" 
wget -q "https://raw.githubusercontent.com/kubernetes/release/${KUBE_RELEASE_VERSION}/cmd/kubepkg/templates/latest/deb/kubeadm/10-kubeadm.conf" 

wget  -q "https://github.com/containernetworking/plugins/releases/download/${CNI_PLUGINS_VERSION}/cni-plugins-linux-${ARCH}-${CNI_PLUGINS_VERSION}.tgz"

wget -q "https://github.com/containerd/containerd/releases/download/v${CONTAINERD_VERSION}/cri-containerd-${CONTAINERD_VERSION}-linux-${ARCH}.tar.gz"

mkdir -p images
cd images
../kubeadm config images pull --config ../kubeadm-config.yaml --image-repository=${IMAGE_REPO}
../kubeadm config images list --config ../kubeadm-config.yaml --image-repository=${IMAGE_REPO} | xargs -I{} bash -c "ctr -n k8s.io i export \$RANDOM.tar.gz {}"

set +uex
