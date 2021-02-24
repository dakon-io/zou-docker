FROM alpine:latest

ENV WORKERS                3
ENV TIMEOUT                60
ENV DB_HOST                localhost
ENV DB_PORT                5432
ENV DB_USERNAME            kitsu
ENV DB_PASSWORD            kitsu
ENV DB_DATABASE            zoudb
ENV KV_HOST                localhost
ENV KV_PORT                6379
ENV SECRET_KEY             mysecretkey
ENV FS_BACKEND             s3
ENV FS_S3_REGION           NULL
ENV FS_S3_ENDPOINT         NULL
ENV FS_S3_ACCESS_KEY       NULL
ENV FS_S3_SECRET_KEY       NULL
ENV MAIL_SERVER            smtp.gmail.com
ENV MAIL_PORT              465
ENV MAIL_USERNAME          NULL
ENV MAIL_PASSWORD          PASS
ENV MAIL_USE_SSL           True
ENV MAIL_DEFAULT_SENDER    NULL
ENV DOMAIN_NAME            localhost
ENV DOMAIN_PROTOCOL        https

RUN apk add --no-cache \
    bash \
    git \
    supervisor \
    ffmpeg \
    python3 \
    py-pip \
    py-pip \
    build-base \
    python3-dev \
    postgresql-dev \
    libjpeg-turbo-dev \
    jpeg-dev \
    libpng-dev \
    libev-dev \
    libevent-dev \
    libffi-dev \
    zlib-dev

# build zou
WORKDIR /opt/zou
ADD zou /opt/zou/
RUN pip3 install -r requirements.txt --no-cache-dir

# setup supervisor
RUN mkdir -p  /var/log/zou
ADD supervisord.conf /etc/supervisord.conf
ADD gunicorn /etc/zou/gunicorn.conf
ADD gunicorn-events /etc/zou/gunicorn-events.conf

EXPOSE 5000 5001
COPY start_zou.sh /opt/zou/

# NOTE: This shell out is needed to avoid RQD getting PID 0 which leads to leaking child processes.
ENTRYPOINT ["./start_zou.sh"]
