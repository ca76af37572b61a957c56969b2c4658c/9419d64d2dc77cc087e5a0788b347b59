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

tail -n 100 /var/log/syslog // see all logs, find first error

cat /etc/passwd // check all users

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

ansible-vault encrypt_string <password> --name <variable_name>


# MYSQL

sudo ss -lnpt | grep 3306 // show mysql listening ports

mysql -u agama -p // open mysql on server

SHOW DATABASES; // show all databases

USE <databas_name>; // use that database

SHOW TABLES; // show tables

sudo mysql -e "SELECT * FROM agama.item" agama // show items


# DNS

## Troubleshooting:

nslookup <name> // name + address

host <ip or name> [dns-server // 8.8.8.8] // a + aaaa + mx

dig [type] <name> [@dns-server /8.8.8.8] // lot stuff

dig A <name> [@dns-server /8.8.8.8]  +short // just the A record 
AAAA
NS
MX

//dig <ip address>.in-addr.arpa // find name

dig PTR <ip address>.in-addr.arpa // find name

find out bind9 is working: install on wm, dig with @wm-ip


## Locations:

nano /etc/resolv.conf
	- delete everything
	- put nameserver bematv-2 addr
	- search pho.ng
 
	nameserver <bematv-2 internal IP>
	search pho.ng
 
 
cat /etc/bind/named.conf
include "/etc/bind/named.conf.options";
include "/etc/bind/named.conf.local";
include "/etc/bind/named.conf.default-zones";


cat /etc/bind/named.conf.default-zones 
	zone "localhost" {
		type master;
		file "/etc/bind/db.local";
	};


cat /etc/bind/db.local 
	;
	; BIND data file for local loopback interface
	;
	$TTL	604800
	@	IN	SOA	localhost. root.localhost. (
					2		; Serial
				604800		; Refresh
				86400		; Retry
				2419200		; Expire
				604800 )	; Negative Cache TTL
	;
	@	IN	NS	localhost.
	@	IN	A	127.0.0.1
	@	IN	AAAA	::1


cat /etc/bind/named.conf.options 
	acl lan { 192.168.42.0/24; 127.0.0.0/8; };
	options {
		directory "/var/cache/bind";
		forwarders {
			1.1.1.1;
			8.8.8.8;
			9.9.9.9;
			9.9.9.10;
		};
		allow-query { 
			lan; 
		};
		dnssec-validation no;
	};


cat /etc/bind/named.conf.local
	zone "pho.ng" {
		type primary;
		file "db.pho";
	};



### db.pho original:

$TTL	604800
pho.ng.	IN	SOA	vm1.pho.ng. king.pho.ng. (
			      2		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
pho.ng.	IN	NS	vm1
vm1	IN	A	192.168.42.166
vm2	IN	A	192.168.42.170

### db.pho modified

$TTL	604800
{{ domain }}.	IN	SOA	bematv-1.{{ domain }}. king.{{ domain }}. (
			      2		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;

{% for vm in groups['dns_servers'] %}
{{ domain }}.	IN	NS	{{ vm }}
{% endfor %}

{% for vm in groups['all'] %}
{{ vm }} IN A {{ hostvars[vm]['ansible_default_ipv4']['address'] }}
{% endfor %}


## Check if running

grep pho /var/log/syslog // check if domain is used by system

system bind9 status // show service running

rndc reload <on dns server> // update the database

rndc querylog [on dns server] + host <domain> [on non dns server] + tail -f /var/log//syslog [on dns server]  // get dns info

named-checkconf // show typos

 
## Debug

gather_facts:yes


- debug:
    var: 
      - inventory_hostname
      - hostvars
      - hostvars['bematv-2']['ansible_default_ipv4']['address']
      - groups
    msg:
      - "{%for bematv in groups['all']%} nameserver {{ hostvars['bematv']['ansible_default_ipv4']['address'] }}{%endfor%}"

- name: Show some variables
  hosts: bematv-1
  gather_facts: no
  tasks:
    - debug:
        var: groups
    - debug:
        var: hostvars
    - debug:
        msg: This bematv IP is {{ hostvars[‘bematv-1’]['ansible_default_ipv4']['address'] }}

- name: Show some variables
  hosts: bematv-2
  tasks:
    - debug:
        msg: This bematv IP is {{ hostvars[‘bematv-2’]['ansible_default_ipv4']['address'] }}
		
### final formula set in a play:
- name: Get IP
  debug:
    msg: 
      - bematv-1 IP is {{ hostvars['bematv-1']['ansible_default_ipv4']['address'] }}
      - bematv-2 IP is {{ hostvars['bematv-2']['ansible_default_ipv4']['address'] }}




# PROMETHEUS

## in vm

uptime // tell the server uptime

free -h // tell memory data

df -h // tell about free disks

ss -ntlp // check listening ports

curl localhost:9100 // check main page?

curl localhost:9100/metris

curl localhost:9100/metris | wc -l // tells how many lines

curl localhost:9100/metris | grep cpu

curl localhost:9090/<url> // show webpage



# GRAFANA

curl localhost:9119
curl localhost:9119/metrics

named -V | grep libxml2

cat /etc/grafana/grafana.ini |grep -v "^#\|^;\|^$"

## dashboard.yaml
	apiVersion: 1

	providers:
	  # <string> an unique provider name. Required
	  - name: 'Main'
		# <int> Org id. Default to 1
		orgId: 1
		# <string> name of the dashboard folder.
		folder: ''
		# <string> folder UID. will be automatically generated if not specified
		folderUid: ''
		# <string> provider type. Default to 'file'
		type: file
		# <bool> disable dashboard deletion
		disableDeletion: false
		# <int> how often Grafana will scan for changed dashboards
		updateIntervalSeconds: 10
		# <bool> allow updating provisioned dashboards from the UI
		allowUiUpdates: false
		options:
		  # <string, required> path to dashboard files on disk. Required when using the 'file' type
		  path: /var/lib/grafana/dashboards
		  # <bool> use folder names from filesystem to create folders in Grafana
		  foldersFromFilesStructure: true
		  
		  
## datasource.yaml
	# config file version
	apiVersion: 1

	datasources:
	 - name: prometheus
	   type: prometheus
	#   orgId: 1
	   url: http://bematv-1:9090/prometheus
	   password:
	   user:
	   database:
	   isDefault: true
	   editable: true
	   
	   


# INFLUXDB

register: <variable>

when: <variable>.changed