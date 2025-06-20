Run below command to generate default Vagrantfile for centos
vagrant init eurolinux-vagrant/centos-stream-9

Replace the Vagrantfile with the file present in this project

Start the vm by running below command
vagrant up

Ssh to the vm
vagrant ssh

Run below command to setup hostname ( Optional)
 sudo vi /etc/hostname
 sudo hostname finance
 exit
 vagrant ssh

Launch http:<ip> & check if finance dashboard appears successfully.


