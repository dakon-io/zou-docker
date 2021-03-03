#!/bin/bash

echo Running Zou...
sed -i "s/workers = .*/workers = $WORKERS/g" /etc/zou/gunicorn.conf
sed -i "s/timeout = .*/timeout = $TIMEOUT/g" /etc/zou/gunicorn.conf
sed -i "s/proxy_read_timeout .*/proxy_read_timeout $TIMEOUT\s;/g" /etc/nginx/http.d/default.conf
GUNICORN_ACTIVE=false
NGINX_ACTIVE=false
GUNICORN_EVENT_ACTIVE=false
RQ_ACTIVE=false
for app in $(echo $APPS | sed "s/,/ /g")
do
    if [ $app = "gunicorn" ]; then
        GUNICORN_ACTIVE=true
        NGINX_ACTIVE=true
    elif [ $app = "gunicorn-event" ]; then
        GUNICORN_EVENT_ACTIVE=true
    elif [ $app = "rq" ]; then
        RQ_ACTIVE=true
    else
        echo "app $app is not found!"
    fi
done
echo "Gunicorn active ? $GUNICORN_ACTIVE"
echo "Nginx active    ? $NGINX_ACTIVE"
echo "Event active    ? $GUNICORN_EVENT_ACTIVE"
echo "RQ active       ? $RQ_ACTIVE"
sed -i "s/GUNICORN_ACTIVE/$GUNICORN_ACTIVE/g" /etc/zou/gunicorn.conf
sed -i "s/NGINX_ACTIVE/$NGINX_ACTIVE/g" /etc/zou/gunicorn.conf
sed -i "s/GUNICORN_EVENT_ACTIVE/$GUNICORN_EVENT_ACTIVE/g" /etc/zou/gunicorn.conf
sed -i "s/RQ_ACTIVE/$RQ_ACTIVE/g" /etc/zou/gunicorn.conf
supervisord -c /etc/supervisord.conf
