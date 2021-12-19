#### Table of contents:  


# Backup Service Level Agreement: SLA 

## Introduction 

### Definition of SLA 
This Service Level Agreement (“SLA”) governs the backup Services. Operations and security teams may update, amend, modify or supplement this SLA from time to time. The terms and conditions of this SLA are applicable to the Managed Backup and Disaster Recovery Services only.

### Structure of SLA 
This SLA describes the backup approach for all services in the infrastructure:

#### Web services - Nginx  

#### App services - Agama 

#### Database services - MySQL, InfluxDB 

#### DNS service - Bind9 

#### Monitoring services - Grafana, Prometheus, Influxdb, Telegraf, Pinger, Bind9 exporter, MySQL exporter, Influxdb exporter, Nginx exporter, Node exporter, Rsyslog, HAProxy exporter, Keepalived exporter 

#### Backup services - Duplicity 

#### Containerisation services - Docker 

#### Load balancing services - HAProxy, Keepalived 

#### Additional services - Agama, uWSGI, Cron, Ansible

### Ansible database - https://github.com/bematv/ica0002 (stores configuration, roles, playbooks to configure all the above-mentioned services) 

Descriptions of backup approaches contain information on specific backup attributes, such as:

1. Backup coverage - what is backed up and what is not 

2. Backup RPO (recovery point objective) - acceptable data loss (time period)

3. Usability - how is the backup recovery verified (backup should be usable)

4. Restoration criteria - when should backup be restored

5. Backup RTO (recovery time objective) - how long will it take to restore the service


### Backup coverage

Backup service covers only the next services:

#### Database services:

##### MySQL Database: Database for Agama web application and user information

##### Influxdb Database: Database for logs and service status

Explanation:

These databases contains user information and interaction with the services. User and the log data cannot be restored by any other means so these services are the most critical assets for the backup process.


Backup RPO
Recovery point objective for:

MySQL equals 4 weeks/28 days.

Influxdb equals 4 weeks/28 days.


### Two types of backup can be produced: full and incremental.

+   Full backup contains the whole backed up data and can be solely used to restore require data or service. Full backups are done for each service covered by our backup strategy according to the backup RPO' schedule.

+ Incremental backup stores only the difference in the data relative to the last incremental backup produced. First incremental backup stores difference from the last created full backup. These backups form a chain, if some links disappear, they cannot be used to restore the data or service, but they allow to use less storage. Incremental backups are not produced done only for any service.

+ +1 Local copy of the databases 


#### Local copies of the databases are created every day at:
+ 01:00 AM UTC+2 Estonian time for MySQL
+ 01:15 AM UTC+2 Estonian time for MySQL
###### This helps keep the data updated till the backup happens

#### Full backup of the databases are created every Sunday at:
+ 01:05 AM UTC+2 Estonian time for MySQL
+ 01:20 AM UTC+2 Estonian time for MySQL

#### Incremetal backup of the databases are created every Monday at:
+ 01:10 AM UTC+2 Estonian time for MySQL
+ 01:25 AM UTC+2 Estonian time for MySQL

#### Explanation:
The 01:10 - 01:30 time window was chosen as the time with the least activity in the region when our service is provided, some backed up services may be in the read-only mode or shutdown.
The time difference between the backups are desiged:
+ For the maximum process time of a copy
+ For the trustworthy difference in the backup naming provided by duplicity service


### Usability
Usability of the last MySQL and Influxdb database backup is regularly checked every 1 week/7 days before new modifications to MySQL and Influxdb database is done. The test is done on the virtual environment setup, simulating our real infrastructure.
Explanation:
Before MYyQL and Influxdb database are modified, new backups are produced. New modifications should be tested in the development environment, this moment could be used to to test backups as well.

### Restoration criteria

Backup restoration of the MySQL and Influxdb data should be done only if it was detected and confirmed that the stored data was corrupted, modified by the unauthorized 1st/3rd party, stolen or deleted.

Explanation:
Backup restoration takes time and computing resources, there is no reason to use it, if the data it covers, was not corrupted.

### Backup RTO

Backup service is expected to take maximum of 1 hours to fully recover all the data.
If the whole infrastructures should be restored, excepted maximum required time equals 2 hours.

Explanation:
Our infrastructure is small and its recovery with Ansible should be swift, meanwhile, to restore the data more time might be required because of the possible bandwidth and storage media limitations.

