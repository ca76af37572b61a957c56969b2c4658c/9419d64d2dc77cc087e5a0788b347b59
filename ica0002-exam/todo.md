# MODE:
    backup
    influxdb_backup
    influxdb_exporter
    keepalived
    mysql
    mysql_backup
    mysql_exporter
    pinger
## OK


# BACKUP

## InfluxDB:
#### cron jobs
    rm -rf /home/backup/influxdb/*; influxd backup -portable -database telegraf /home/backup/influxdb

    duplicity --no-encryption full /home/backup/influxdb/ rsync://bematv@backup//home/bematv/influxdb/

    duplicity --no-encryption incremental /home/backup/influxdb/ rsync://bematv@backup//home/bematv/influxdb/

#### delete
    service telegraf stop
    influx -execute 'DROP DATABASE telegraf'
    influx
    show databases;
    exit

#### restore
    sudo su - backup
    rm -r /home/backup/restore/*
    duplicity --no-encryption restore rsync://bematv@backup//home/bematv/influxdb/ /home/backup/restore/
    exit
    sudo su -
    influxd restore -portable -database telegraf /home/backup/restore/
    service telegraf start
## OK
   
## Mysql:
#### cron jobs
    backup ssh {{ backup_ssh }} mkdir mysql

    sudo -su backup mysqldump agama > /home/backup/mysql/agama.sql

    duplicity full --no-encryption --allow-source-mismatch /home/backup/mysql/ rsync://bematv@backup//home/bematv/mysql/

    duplicity incremental --no-encryption --allow-source-mismatch /home/backup/mysql/ rsync://bematv@backup//home/bematv/mysql/

#### delete
        mysql -Ee 'SHOW REPLICA STATUS'
        mysql -e 'SELECT * FROM agama.item'
        mysql -e 'DROP TABLE agama.item'
        mysql -e 'SELECT * FROM agama.item'

#### restore
        sudo su - backup
        rm -r /home/backup/restore/*
        duplicity --no-encryption restore rsync://bematv@backup//home/bematv/mysql/ /home/backup/restore/agama
        exit
        sudo su -
        mysql agama < /home/backup/restore/agama/agama.sql
        mysql -e 'SELECT * FROM agama.item'
## OK
# BACKUP OK


# MYSQL REPLICATION CHECK
## for read read status change:
#### Mysql tasks main: 
    community.mysql.mysql_variables:
    variable: read_only
    value: "{{ 'OFF' if inventory_hostname == mysql_host else 'ON' }}"
    mode: persist
## OK


# DEBUG ALL ERRORS
    prometheus-mysqld-exporter listening error
## OK


# HAPROXY & KEEPALIVED CHECK
    services changed status
## OK


# SERVICE STOP & SERVICE PURGE
#### Stop Exporters:
    services dissapears

#### Stop Services:
    services turns red

#### Purge Services:
    Exporters:
    services dissapears
    Services:
    services turns red
## OK

# GRAFANA TO THE SKY
    IT IS IN THE SKY
## OK


# GET ALL ORIGINAL CONFIG FILES
    It is in a secret txt
## OK

