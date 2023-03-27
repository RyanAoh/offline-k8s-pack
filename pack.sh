source env.sh
set -ue

rm -rf $PACK_DIR
mkdir -p "$PACK_DIR"

envsubst < kubeadm-config.yaml > $PACK_DIR/kubeadm-config.yaml
envsubst < setup.sh > $PACK_DIR/setup.sh
chmod +x $PACK_DIR/setup.sh

./download.sh $PACK_DIR

makeself  $PACK_DIR okp-$K8S_VERSION.run "setup k8s"  ./setup.sh

set +ue