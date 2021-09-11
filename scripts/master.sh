#! /bin/bash

sudo add-apt-repository ppa:git-core/ppa

sudo apt update
sudo apt upgrade
sudo apt install python3-pip curl vim unzip git geomview zsh p7zip-full unzip jq awscli -y

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

pip3 install bpytop --upgrade

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

MASTER_IP="192.168.0.200"
NODENAME=$(hostname -s)
POD_CIDR="192.168.0.0/16"

sudo kubeadm config images pull

echo "Preflight Check Passed: Downloaded All Required Images"

sudo kubeadm init --apiserver-advertise-address=$MASTER_IP  --apiserver-cert-extra-sans=$MASTER_IP --pod-network-cidr=$POD_CIDR --node-name $NODENAME --ignore-preflight-errors Swap

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

# Save Configs to shared /Vagrant location

# For Vagrant re-runs, check if there is existing configs in the location and delete it for saving new configuration.

#config_path="/vagrant/configs"

#if [ -d $config_path ]; then
#   rm -f $config_path/*
#else
#   mkdir -p /vagrant/configs
#fi

#cp -i /etc/kubernetes/admin.conf /vagrant/configs/config
#touch /vagrant/configs/join.sh
#chmod +x /vagrant/configs/join.sh       


#kubeadm token create --print-join-command > /vagrant/configs/join.sh

# Install Calico Network Plugin

#curl https://docs.projectcalico.org/manifests/calico.yaml -O

#kubectl apply -f calico.yaml

# Install Metrics Server

#kubectl apply -f https://raw.githubusercontent.com/scriptcamp/kubeadm-scripts/main/manifests/metrics-server.yaml

# Install Kubernetes Dashboard

#kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml

# Create Dashboard User

#cat <<EOF | kubectl apply -f -
#apiVersion: v1
#kind: ServiceAccount
#metadata:
#  name: admin-user
#  namespace: kubernetes-dashboard
#EOF

#cat <<EOF | kubectl apply -f -
#apiVersion: rbac.authorization.k8s.io/v1
#kind: ClusterRoleBinding
#metadata:
#  name: admin-user
#roleRef:
#  apiGroup: rbac.authorization.k8s.io
#  kind: ClusterRole
#  name: cluster-admin
#subjects:
#- kind: ServiceAccount
#  name: admin-user
#  namespace: kubernetes-dashboard
#EOF

#kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}" >> /vagrant/configs/token

#sudo -i -u vagrant bash << EOF
#mkdir -p /home/vagrant/.kube
#sudo cp -i /vagrant/configs/config /home/vagrant/.kube/
#sudo chown 1000:1000 /home/vagrant/.kube/config
#EOF