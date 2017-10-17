# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "private_network", ip: "192.168.50.4",
    virtualbox__intnet: true

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"

  end
  #
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y software-properties-common
    sudo apt-add-repository -y ppa:ansible/ansible
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu trusty stable"
    sudo apt-get update
    sudo apt-get install -y --force-yes python-netaddr python-pip ansible docker-ce
    echo "cd /vagrant" >> /home/vagrant/.bashrc
    cat /vagrant/aliases >> /home/vagrant/.bashrc
    sudo groupadd docker
    sudo usermod -aG docker vagrant
    sudo curl -L https://github.com/docker/compose/releases/download/1.15.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
  SHELL
end
