# Defines our Vagrant environment
#
# 

Vagrant.configure("2") do |config|

  # create load balancer
  config.vm.define :lb do |lb_config|
      lb_config.vm.box = "ubuntu/trusty64"
      lb_config.vm.hostname = "lb"
      lb_config.vm.network :private_network, ip: "192.168.123.11"
      lb_config.vm.network "forwarded_port", guest: 8080, host: 8080
      lb_config.vm.provider "virtualbox" do |vb|
        vb.memory = "256"
      end
      lb_config.vm.provision :shell, path: "bootstrap-nodes.sh"
  end
 
   # create web servers
   (1..2).each do |i|
     config.vm.define "wp#{i}" do |node|
         node.vm.box = "ubuntu/trusty64"
         node.vm.hostname = "wp#{i}"
         node.vm.network :private_network, ip: "192.168.123.2#{i}"
         node.vm.network "forwarded_port", guest: 80, host: "808#{i}"
         node.vm.provider "virtualbox" do |vb|
           vb.memory = "256"
         end
         node.vm.provision :shell, path: "bootstrap-nodes.sh"
     end
   end

     # create the backend node (db, nfs, memcached)
   config.vm.define :be do |be|
       be.vm.box = "ubuntu/trusty64"
       be.vm.hostname = "be"
       be.vm.network :private_network, ip: "192.168.123.31"
      be.vm.provider "virtualbox" do |vb|
         vb.memory = "256"
       end
      be.vm.provision :shell, path: "bootstrap-nodes.sh"
   end


  # create management node
  config.vm.define :mgmt do |mgmt|
      mgmt.vm.box = "ubuntu/trusty64"
      mgmt.vm.hostname = "mgmt"
      mgmt.vm.network :private_network, ip: "192.168.123.10"
      mgmt.vm.provider "virtualbox" do |vb|
        vb.memory = "256"
      end
      mgmt.vm.provision :shell, path: "bootstrap-mgmt.sh"
  end

end
