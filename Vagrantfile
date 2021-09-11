Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: <<-SHELL
      apt-get update -y
      echo "192.168.0.200  master-node" >> /etc/hosts
      echo "192.168.0.201  worker-node01" >> /etc/hosts
      echo "192.168.0.202  worker-node02" >> /etc/hosts
  SHELL
  
  config.vm.define "master" do |master|
    master.vm.box = "bento/ubuntu-18.04"
    master.vm.hostname = "master-node"
    master.vm.network "public_network", ip: "192.168.0.200"
    master.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.cpus = 2
    end
    master.vm.provision "shell", path: "scripts/common.sh"
    master.vm.provision "shell", path: "scripts/master.sh"
  end

  (1..2).each do |i|

  config.vm.define "node0#{i}" do |node|
    node.vm.box = "bento/ubuntu-18.04"
    node.vm.hostname = "worker-node0#{i}"
    node.vm.network "public_network", ip: "192.168.0.20#{i}"
    node.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.cpus = 2
    end
    node.vm.provision "shell", path: "scripts/common.sh"
  end
  
  end
end
