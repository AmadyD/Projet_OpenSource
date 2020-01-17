# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise64"
  #config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", 256]
  end

  config.vm.define :haproxy, primary: true do |haproxy_config|

    haproxy_config.vm.hostname = 'haproxy'
    haproxy_config.vm.network :forwarded_port, guest: 8080, host: 8080
    haproxy_config.vm.network :forwarded_port, guest: 80, host: 8081

    haproxy_config.vm.network :private_network, ip: "172.28.33.10"
    haproxy_config.vm.provision :shell, :path => "haproxy-setup.sh"

  end
  config.vm.define :web1 do |web1_config|

    web1_config.vm.hostname = 'web1'
    web1_config.vm.network :private_network, ip: "172.28.33.11"
    web1_config.vm.provision :shell, :path => "web1-setup.sh"


  end
  config.vm.define :web2 do |web2_config|

    web2_config.vm.hostname = 'web2'
    web2_config.vm.network :private_network, ip: "172.28.33.12"
    web2_config.vm.provision :shell, :path => "web2-setup.sh"

  end

  config.vm.define :databaseServer do |mysql57_config|
  mysql57_config.vm.hostname = "mysql57"
  mysql57_config.vm.network :private_network, ip: "172.28.33.13"
  mysql57_config.vm.provision "shell", path: "bootstrap.sh"
  end

   config.vm.define :elastic do |elastic_config|
    elastic_config.vm.hostname = "elastic7x"
    elastic_config.vm.network :forwarded_port, host: 9200, guest: 9200 # Elasticsearch (http)
    elastic_config.vm.network :forwarded_port, host: 9300, guest: 9300 # Elasticsearch (transport)
    elastic_config.vm.network :forwarded_port, host: 5601, guest: 5601 # Kibana
    elastic_config.vm.network :forwarded_port, host: 5044, guest: 5044 # Logstash
    elastic_config.vm.network :private_network, ip: "172.28.33.14"
    elastic_config.vm.provision "shell", path: "elk.sh"

    end

end
