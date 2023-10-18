#!/bin/bash

URL='http://127.0.0.1:9093/api/v1/alerts'
ALERT_NAME="mock_alert_info_from_curl"


log_popup(){
  printf "\033[34;6m $1 \033[0m"
}


log(){
  printf "\033[34;3m $1 \033[0m"
}


log "
======================================================
press any key to send FIRING event to the alertmanager
======================================================
"
read


_TIMEZONE_JOINED=$(date +%z)  # -0300
TIMEZONE=$(echo ${_TIMEZONE_JOINED:0:3}:${_TIMEZONE_JOINED:3})  # -03:00

DATE_START_AT=$(date +"%Y-%m-%dT%H:%M:%S$TIMEZONE") # 2022-09-15T20:13:18-03:00
PAYLOAD_FIRING=$(cat << EOF
[
  {
    "status": "firing",
    "labels": {
      "alertname": "$ALERT_NAME",
      "group": "devops",
      "severity": "info"
    },
    "annotations": {
      "summary": "problem $DATE_START_AT",
      "description": "problem $DATE_START_AT"
    },
    "generatorURL": "http://prometheus.int.example.net/<generating_expression>",
    "startsAt": "$DATE_START_AT"
  }
]
EOF
)

log "
>>> send...

$(echo $PAYLOAD_FIRING | jq)
"

RESPONSE=$(curl -sS -XPOST "$URL" -d "$PAYLOAD_FIRING")

log_popup "
<<< receive...

$(echo $RESPONSE | jq)
"


log "
============================================================
press any key to send RESOLVED event to the alertmanager ...
"
read


DATE_END_AT=$(date +"%Y-%m-%dT%H:%M:%S$TIMEZONE") # 2022-09-15T20:13:18-03:00
PAYLOAD_RESOLVED=$(cat << EOF
[
  {
    "status": "resolved",
    "labels": {
      "alertname": "$ALERT_NAME",
      "group": "devops",
      "severity": "info"
    },
    "annotations": {
      "summary": "resolved $DATE_END_AT",
      "description": "resolved $DATE_END_AT"
    },
    "generatorURL": "http://prometheus.int.example.net/<generating_expression>",
    "startsAt": "$DATE_START_AT",
    "endsAt": "$DATE_END_AT"
  }
]
EOF
)

log "
>>> send...

$(echo $PAYLOAD_RESOLVED | jq)
"

RESPONSE=$(curl -sS -XPOST "$URL" -d "$PAYLOAD_RESOLVED")

log_popup "
<<< receive...

$(echo $RESPONSE | jq)
"
