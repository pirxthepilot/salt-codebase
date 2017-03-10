#!/bin/bash

hn=$(hostname); phpvers=$(php --version | grep "^PHP" | awk '{print $2}'); httpd -S | grep "/etc/httpd" | grep -v "^ServerRoot\|^Mutex\|^Main\|localhost" | awk '{print $(NF-1)}' | sort | uniq | while read site; do echo "|$phpvers|$hn|$site|"; done
