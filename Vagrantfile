Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: <<-SHELL
      echo "192.168.0.200  master" >> /etc/hosts
      echo "192.168.0.201  node01" >> /etc/hosts
      echo "192.168.0.202  node02" >> /etc/hosts
  SHELL
  config.vm.provision "shell", inline: <<-SHELL
      echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZhCHPAjXKHomB0aemSppkVahG4t1kpSn1LlugyNFTqXCoVAW5E5Oao+HJEYeN7g8k7WOq0XOGWqqoSTfeuj/tzTqld+d469zDbvwcOyASmmx4SOQnhHNrHS4BqdcJnHFXI45PntEwU5NNN4414d2aK6RVAuOx4ETEMF1Uem/swk0JOHUb8XItrdhKsn/hLkOEANhkWd/4APDDyfKI7uYHp/AU0f2l1QCPCLR3VELOWJQcqhSXtFCIYP4Wfso3Ura85NVDtK9bepdumiom6yTWRQIWw9S42FehRIYc6BMuqcoAn7H6askm/PgJl0BbKQBo4QKl3kxZAA9WaDDKFGxF" >> /home/vagrant/.ssh/authorized_keys
  SHELL
  
  config.vm.define "master" do |master|
    master.vm.box = "bento/ubuntu-18.04"
    master.vm.hostname = "master"
    master.vm.network "public_network", ip: "192.168.0.200"
    master.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.cpus = 2
    end
    master.vm.provision "shell", path: "scripts/commons.sh"
    master.vm.provision "shell", path: "scripts/master.sh"
  end

  (1..2).each do |i|

  config.vm.define "node0#{i}" do |node|
    node.vm.box = "bento/ubuntu-18.04"
    node.vm.hostname = "node0#{i}"
    node.vm.network "public_network", ip: "192.168.0.20#{i}"
    node.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
        vb.cpus = 2
    end
    node.vm.provision "shell", path: "scripts/commons.sh"
  end
  
  end
end
