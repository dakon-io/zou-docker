#!/bin/bash

echo Running Zou...
sed -i "s/workers = .*/workers = $WORKERS/g" /etc/zou/gunicorn.conf
sed -i "s/timeout = .*/timeout = $TIMEOUT/g" /etc/zou/gunicorn.conf
sed -i "s/proxy_read_timeout .*/proxy_read_timeout $TIMEOUT/g" /etc/nginx/conf.d/default.conf
supervisord -c /etc/supervisord.conf
