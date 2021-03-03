#!/bin/bash

echo Running Zou...
sed -i "s/workers = .*/workers = $WORKERS/g" /etc/zou/gunicorn.conf
sed -i "s/timeout = .*/timeout = $TIMEOUT/g" /etc/zou/gunicorn.conf
sed -i "s/proxy_read_timeout .*/proxy_read_timeout $TIMEOUT\s;/g" /etc/nginx/http.d/default.conf
for app in $(echo $APPS | sed "s/,/ /g")
do
    # call your procedure/other scripts here below
    # echo "$app"
    if [ $app = "gunicorn" ]; then
        sed -i 's/GUNICORN_ACTIVE/true/g' /etc/supervisord.conf
        sed -i 's/NGINX_ACTIVE/true/g' /etc/supervisord.conf
    elif [ $app = "gunicorn-event" ]; then
        sed -i 's/GUNICORN_EVENT_ACTIVE/true/g' /etc/supervisord.conf
    elif [ $app = "rq" ]; then
        sed -i 's/RQ_ACTIVE/true/g' /etc/supervisord.conf
    else
        echo "app $app is not found!"
    fi
done
supervisord -c /etc/supervisord.conf
