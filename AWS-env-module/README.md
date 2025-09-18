Ansible install on master server: 
sudo apt update
sudo apt install ansible
ssh enable:
creaste keypair: ssh-keygen -t ed25519
ssh copy id: ssh-copy-id -i /home/vibin/.ssh/id_ed25519.pub ec2-user@18.144.169.161
ansible --version: ansible 2.9.6

