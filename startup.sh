#!/usr/bin/env bash

if [ "$MODE" = "web" ]; then
    gunicorn -b 127.0.0.1:$PORT -w $WORKER --timeout $TIMEOUT zou.app:app
elif [ "$MODE" = "event" ]; then
    gunicorn -k geventwebsocket.gunicorn.workers.GeventWebSocketWorker -b 127.0.0.1:$PORT zou.event_stream:app
else
  echo "Mode *$MODE* are not allowed."
fi

