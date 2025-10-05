Run below command to generate default Vagrantfile for centos
vagrant init ubuntu/focal64

Create the vagrant file and add/uncomments following lines-
1) config.vm.box = "eurolinux-vagrant/centos-stream-9"
2) config.vm.network "private_network", ip: "192.168.56.22"
3) config.vm.network "public_network"
4)config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
      vb.memory = "1024"
 end
 

 Start the vm by running below command
 vagrant up

 Ssh to the vm
 vagrant ssh

Run below command to setup hostname ( Optional)
 sudo vi /etc/hostname
 sudo hostname wordpress
 exit
 vagrant ssh

Launch below url or go through the document- installation_commands.txt
https://ubuntu.com/tutorials/install-and-configure-wordpress

Launch  url and check if wordpress dashboard successfully.