FIX

# Install and configure infrastructure with Ansible:

## Install/Restore with Ansible
Anyone with the privatekey and a local repository from https://github.com/bematv/ica0002 can backup/restore the services the following way:

### Install/Restore Infrastructure

#### Use this command if you don't know what is the issue!
#### This command should restore the entire infrastructure to the desired state:
    ansible-playbook infra.yaml

If you know the issue is with the backup, it is mandatory to first run the backup step (mentioned on the bottom) and only after you should run this command!


### Install/Restore individual modules

This command will collect information about the vm-s:

    ansible-playbook infra-yaml --tags INIT

This command will install/restore duplicity service on the vm-s:
    
    ansible-playbook infra-yaml --tags BACKUP

This command will install/restore duplicity service on the vm-s:
    
    ansible-playbook infra-yaml --tags BACKUP

This command will fix the docker container building and image creation SSL handshake error on the vm-s:
    
    ansible-playbook infra-yaml --tags IPTABLES

This command will install/restore MySQL service and create the mysql backup cron file for agama and user information on the vm-s:
    
    ansible-playbook infra-yaml --tags MYSQL

This command will install/restore docker service on the vm-s:
    
    ansible-playbook infra-yaml --tags DOCKER

This command will install/restore nginx service on the vm-s:
    
    ansible-playbook infra-yaml --tags NGINX

This command will install/restore uwsgi service and create the Agama docker image on the vm-s:
    
    ansible-playbook infra-yaml --tags WEB_SERVERS

This command will install/restore prometheus service on the vm-s:
    
    ansible-playbook infra-yaml --tags PROMETHEUS

This command will install/restore influxdb, telegraf and create the influxdb backup cron file for influxdb log service on the vm-s:
    
    ansible-playbook infra-yaml --tags INFLUXDB

This command will install/restore pinger service on the vm-s:
    
    ansible-playbook infra-yaml --tags PINGER

This command will install/restore rsyslog service on the vm-s:
    
    ansible-playbook infra-yaml --tags RSYSLOG

This command will install/restore keepalived service on the vm-s:
    
    ansible-playbook infra-yaml --tags KEEPALIVED

This command will install/restore haproxy service on the vm-s:
    
    ansible-playbook infra-yaml --tags HAPROXY

This command will install/restore all exporter services on the vm1:
    
    ansible-playbook infra-yaml --tags VM1_EXPORTERS

This command will install/restore all exporter services on the vm2:
    
    ansible-playbook infra-yaml --tags VM2_EXPORTERS

This command will install/restore all exporter services on the vm3:
    
    ansible-playbook infra-yaml --tags VM3_EXPORTERS

This command will install/restore grafana service by creating the Grafana docker image on the vm-s:
    
    ansible-playbook infra-yaml --tags GRAFANA


### Install/Restore service modules

This command will install/restore all application services on the vm-s:

    ansible-playbook infra-yaml --tags APPLICATION

This command will install/restore all internal services on the vm-s:

    ansible-playbook infra-yaml --tags INTERNAL

This command will install/restore all database services with their backup utilities on the vm-s:

    ansible-playbook infra-yaml --tags DATABASE

This command will install/restore all exporter services on the vm-s:

    ansible-playbook infra-yaml --tags EXPORTER

This command will install/restore all dns services on the vm-s:

    ansible-playbook infra-yaml --tags DNS


### Install/Restore Infrastructure

#### Use this command if you dont know what is the issue!
#### This command should restore the entire infrastructure for the desired state:
    ansible-playbook infra.yaml

If you know the issue is with the backup, it is mandatory to first run the backup step (mentioned below) and only after you should run this command!

# Restore MySQL data from the backup:

Since backup user is not configured properly, the easiest way is to first login to the user backup, then use duplicity to get
the backup from the remote server. The tail command will ensure you, that the backup exist and we can use it.
The last step will recover the database and drop the old one.


1. sudo su - backup
2. rm -r restore/
3. duplicity --no-encryption restore rsync://bematv@backup//home/bematv /home/backup/restore/agama
4. exit
5. sudo su -
6. mysql agama < /home/backup/restore/agama.sql

        sudo su - backup

        rm -r restore/

        duplicity --no-encryption restore rsync://bematv@backup//home/bematv/mysql/ /home/backup/restore/agama

        exit

        sudo su -

        mysql agama < /home/backup/restore/agama/agama.sql


# Restore InfluxDB data from the backup:


In the first step, you have to become backup user in order to make the second step, which is to download backup from the remote server.
In the thirs step, you have exit user backup, to login to user root in step 4. Then, after stopping the telegraf service, influxdb will drop its database.
In step 7, we restore the EMPTY database with the file that we downlaoded, then start the telegraf service in the last step.

1. sudo su - backup
2. rm -r restore/
3. duplicity --no-encryption restore rsync://bematv@backup//home/bematv /home/backup/restore/
4. exit
5. sudo su -
6. service telegraf stop
7. influxd restore -portable -database telegraf /home/backup/restore/
8. service telegraf start

        sudo su - backup

        rm -r restore/

        duplicity --no-encryption restore rsync://bematv@backup//home/bematv/influxdb/ /home/backup/restore/

        exit

        sudo su -

        influxd restore -portable -database telegraf /home/backup/restore/

        service telegraf start

