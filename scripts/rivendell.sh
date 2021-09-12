#! /bin/bash

cat /vagrant/configs/g3araujo.pub >> /home/vagrant/.ssh/authorized_keys

# Variable Declaration

KUBERNETES_VERSION="1.19.5-00"
DOCKER_VERSION="5:19.03.15~3-0~ubuntu-bionic"

# disable swap 
sudo swapoff -a

# keeps the swaf off during reboot
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Install Docker 19.03.15

sudo apt-get update

sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

sudo bash -c 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg'

sudo bash -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null'

sudo apt-get update

sudo apt-get install -y docker-ce=$DOCKER_VERSION docker-ce-cli=$DOCKER_VERSION containerd.io

# Following configurations are recomended in the kubenetes documentation for Docker runtime. Please refer https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker

sudo mkdir /etc/docker

sudo bash -c 'cat << EOF | sudo tee -a /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}
EOF'

sudo mkdir /etc/modules-load.d

sudo bash -c 'cat << EOF | sudo tee -a /etc/modules-load.d/k8s.conf
br_netfilter
ip_vs
ip_vs_rr
ip_vs_sh
ip_vs_wrr
nf_conntrack_ipv4
EOF'

sudo apt-get update
sudo apt-get upgrade -y

sudo mkdir -p /etc/systemd/system/docker.service.d

sudo systemctl daemon-reload
sudo systemctl restart docker

echo "Docker Runtime Configured Successfully"

sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl gnupg2

sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -


The redirection is done by the shell before sudo is even started. So either make sure the redirection happens in a shell with the right permissions

sudo bash -c  'echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list'

sudo apt-get update

sudo apt-get install -y kubelet=$KUBERNETES_VERSION kubectl=$KUBERNETES_VERSION kubeadm=$KUBERNETES_VERSION

sudo apt-mark hold kubelet kubeadm kubectl

sudo systemctl enable docker && sudo systemctl start docker

sudo systemctl enable kubelet && sudo systemctl start kubelet

sudo bash -c 'cat << EOF | sudo tee -a /etc/sysctl.d/k8s.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF'

sudo apt-get install -y bash-completion

kubectl completion bash > tmp.txt

sudo mv tmp.txt /etc/bash_completion.d/kubectl
