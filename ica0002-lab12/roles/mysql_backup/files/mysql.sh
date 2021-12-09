#!/bin/bash

mysqldump agama > agama.sql
scp agama.sql bematv@backup:
duplicity --no-encryption full /home/backup/mysql/ rsync://bematv@backup.pho.ng//home/bematv/
