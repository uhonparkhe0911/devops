Run below command to generate default Vagrantfile for centos
vagrant init eurolinux-vagrant/centos-stream-9

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
 sudo hostname finance
 exit
 vagrant ssh

Run below command to install required things
sudo yum install wget httpd unzip zip -y

Run below commands to start httpd service
systemctl start httpd
systemctl enable httpd

Check the ip address of vm
ip addr show

Launch http:<ip> and check if http website is appearing or network
Also you can create a new file index.html in /var/www/html with some text in it and relaunch the url to check if it appears


On the vm download the mini finance template from tooplate.command
wget https://www.tooplate.com/mini-templates/2135_mini_finance.zip

Unzip and go to the directory
unzip 2135_mini_finance.zip
cd 2135_mini_finance

Copy everything into /var/www/html
cp -r * /var/www/html

Relaunch the url and check if mini finance dashboard appears successfully

