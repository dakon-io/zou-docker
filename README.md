# kitsu-docker

A Custom Kitsu Dockerfile.

Usage
-----

Build Docker Image
------------------

You have two options:
1. Build image localy

    `docker build .`

2. Build image and push to registry (for example bellow is using google container registry)

    ```
    export TAG_NAME=latest
    export PROJECT_NAME=[PROJECT_NAME]
    ```

    (a) Build container

    `docker build -t gcr.io/$PROJECT_NAME/cgwire/zou:$TAG_NAME -f cuebot/Dockerfile .`

    (b) Push image to registry (for example bellow is using google container registry)

    `docker push gcr.io/$PROJECT_ID/cgwire/zou:$TAG_NAME`

Create Container
----------------

~~~~
# docker run \
--name [CONTAINER_NAME] \
--privileged \
--network host \
-dit \
-e WORKERS=[NUMBER_GUNICORN_WORKERS] \
-e TIMEOUT=[NUMBER_REQUEST_TIMEOUT] \
-e DB_HOST=[DATABASE_HOST] \
-e DB_PORT=[DATABASE_PORT] \
-e DB_USERNAME=[DATABASE_USERNAME] \
-e DB_PASSWORD=[DATABASE_PASSWORD] \
-e DB_DATABASE=[DATABASE_NAME] \
-e KV_HOST=[REDIS_HOST] \
-e KV_PORT=[REDIS_PORT] \
-e SECRET_KEY=[SECRET_KEY] \
-e FS_BACKEND=s3 \
-e FS_S3_REGION=[S3_REGION] \
-e FS_S3_ENDPOINT=[S3_ENDPOINT] \
-e FS_S3_ACCESS_KEY=[S3_ACCESS_KEY] \
-e FS_S3_SECRET_KEY=[S3_ACCESS_KEY_SECRET] \
-e MAIL_SERVER=smtp.gmail.com \
-e MAIL_PORT=465 \
-e MAIL_USERNAME=[MAIL_USERNAME] \
-e MAIL_PASSWORD=[MAIL_PASSWORD] \
-e MAIL_USE_SSL=True \
-e MAIL_DEFAULT_SENDER=your_email_username \
-e DOMAIN_NAME=example.com \
-e DOMAIN_PROTOCOL=[http/https] \
-e APPS=gunicorn,gunicorn-event,rq \
<IMAGE_ID>
~~~~
