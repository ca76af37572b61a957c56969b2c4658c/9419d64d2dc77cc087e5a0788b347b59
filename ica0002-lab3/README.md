# ica0002
Benedek Matveev 201840IVSB

commands:

#SSH
ls -la ~/.ssh  // show ssh keys
ssh-keygen // generate new ssh keys

ssh -p122 ubuntu@193.40.156.86 uptime // check server connectiity
ssh -p122 ubuntu@193.40.156.86 // ssh into virtual machine

#Ansible
ansible-playbook infra.yaml // play the main playbook
