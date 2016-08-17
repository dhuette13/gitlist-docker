#!/bin/bash

service php5-fpm restart
nginx -c /etc/nginx/nginx.conf
