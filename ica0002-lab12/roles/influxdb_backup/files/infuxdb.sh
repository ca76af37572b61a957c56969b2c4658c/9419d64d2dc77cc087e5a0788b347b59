#!/bin/bash

influxd backup -database telegraf /home/backup/backup/influxdb
rm -rf /home/backup/influxdb/*; influxd backup -portable -database telegraf /home/backup/influxdb

