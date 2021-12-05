# ica0002
Benedek Matveev 201840IVSB

commands:

# SSH
ls -la ~/.ssh  // show ssh keys
ssh-keygen // generate new ssh keys

ssh -p122 ubuntu@193.40.156.86 uptime // check server connectivity
ssh -p122 ubuntu@193.40.156.86 // ssh into virtual machine

#Ansible
ansible-playbook infra.yaml // play the main playbook
ansible-playbook infra.yaml -vvv // play the main playbook with more info


# TROUBLESHOOTING
## Service not running
ps ax | grep <my-process-name>
- ps   - lists running OS processes
- grep  - filter out all but your service process

How to detect, option 2:
systemctl status <my-service-name>

Alternative:
service <my-service-name> status


## Configuration syntax problems
Example command to check the service configuration syntax:
<my-service-name> -t
visudo -cf <service-path>
named-checkconf <path/file-name>
named-checkzone </path/file-name>

## Ansible module
validate: nginx -t -c %s


## Check Logs
Logs:
- /var/log/<service-name>

Alternative commands for Systemd journal:
- journalctl -fu <service-name>
- journalctl -xn

Follow logs:
tail -f /var/log/nginx/error.log /var/log/syslog

Only print needed logs (containing cron in this example):
grep -i cron /var/log/syslog

Filter out some lines (print all but lines containing systemd in this example):
grep -v systemd /var/log/syslog


## Verbose (debug) mode:
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

Verbose (debug) mode:
- ansible-playbook -v infra.yaml
- curl -v http://localhost:8080
- wget -d http://localhost:8080
- ssh -vvv my-user@my-server


## Cheat Sheet
### Services and Processes
Process running? // ps ax | grep <process>

Service status: // systemctl status <service>

Config check: // nginx -t

Verbose mode: // curl -v; ssh -vvv

Service logs: 
/var/log/<service>/*  
journalctl -fu <service>

System logs: 
/var/log/syslog
journalctl -xn

Help: // <x> --help; man <x>; info <x>

### Connectivity
Network connected? // ping 1.1.1.1

IP address info: // ip a

Route info: // route

Reach other node: // ping <ip>

Probe remote port: // nc -vz <ip> <port>

Resolve hostname: // host <hostname> [<ns>]

Listening services: // netstat -lnptu


# CRYPTOGRAPHY

ansible-vault encrypt <FILE>

ansible-vault view <FILE>


# MYSQL

sudo ss -lnpt | grep 3306 // show mysql listening ports

mysql -u agama -p // open mysql on server

SHOW DATABASES; // show all databases

USE <databas_name>; // use that database

SHOW TABLES; // show tables

sudo mysql -e "SELECT * FROM agama.item" agama // show items