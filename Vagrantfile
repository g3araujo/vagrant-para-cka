Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: <<-SHELL
      echo "192.168.0.200  gandalf" >> /etc/hosts
      echo "192.168.0.201  hobbit01" >> /etc/hosts
      echo "192.168.0.202  hobbit02" >> /etc/hosts
  SHELL
  
  config.vm.define "gandalf" do |gandalf|
    gandalf.vm.box = "bento/ubuntu-18.04"
    gandalf.vm.hostname = "gandalf"
    gandalf.vm.network "public_network", ip: "192.168.0.200"
    gandalf.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.cpus = 2
    end
    gandalf.vm.provision "shell", path: "scripts/rivendell.sh"
    gandalf.vm.provision "shell", path: "scripts/gandalf.sh"
  end

  (1..2).each do |i|

  config.vm.define "hobbit0#{i}" do |hobbit|
    hobbit.vm.box = "bento/ubuntu-18.04"
    hobbit.vm.hostname = "hobbit0#{i}"
    hobbit.vm.network "public_network", ip: "192.168.0.20#{i}"
    hobbit.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.cpus = 2
    end
    hobbit.vm.provision "shell", path: "scripts/rivendell.sh"
  end
  
  end
end
