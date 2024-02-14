#!/bin/bash
#
# >>> https://github.com/elastic/helm-charts/blob/main/elasticsearch/templates/statefulset.yaml#L238

set -e

# Exit if OPENSEARCH_PASSWORD in unset
if [ -z "${OPENSEARCH_PASSWORD}" ]; then
    echo "OPENSEARCH_PASSWORD variable is missing, exiting"
    exit 1
fi

# If the node is starting up wait for the cluster to be ready (request params: "{{ .Values.clusterHealthCheckParams }}" )
# Once it has started only check that the node itself is responding
START_FILE=/tmp/.es_start_file

# Disable nss cache to avoid filling dentry cache when calling curl
# This is required with Elasticsearch Docker using nss < 3.52
export NSS_SDB_USE_CACHE=no

http () {
    local path="${1}"
    local args="${2}"
    set -- -XGET -s

    if [ "$args" != "" ]; then
    set -- "$@" $args
    fi

    set -- "$@" -u "elastic:${OPENSEARCH_PASSWORD}"

    curl --output /dev/null -k "$@" "https://127.0.0.1:9200${path}"
}

if [ -f "${START_FILE}" ]; then
    echo 'Elasticsearch is already running, lets check the node is healthy'
    HTTP_CODE=$(http "/" "-w %{http_code}")
    RC=$?
    if [[ ${RC} -ne 0 ]]; then
    echo "curl --output /dev/null -k -XGET -s -w '%{http_code}' \${BASIC_AUTH} https://127.0.0.1:9200/ failed with RC ${RC}"
    exit ${RC}
    fi
    # ready if HTTP code 200
    if [[ ${HTTP_CODE} == "200" ]]; then
    exit 0
    else
    echo "curl --output /dev/null -k -XGET -s -w '%{http_code}' \${BASIC_AUTH} https://127.0.0.1:9200/ failed with HTTP code ${HTTP_CODE}"
    exit 1
    fi

else
    echo 'Waiting for elasticsearch cluster to become ready (request params: "{{ .Values.clusterHealthCheckParams }}" )'
    if http "/_cluster/health?{{ .Values.clusterHealthCheckParams }}" "--fail" ; then
    touch ${START_FILE}
    exit 0
    else
    echo 'Cluster is not yet ready (request params: "{{ .Values.clusterHealthCheckParams }}" )'
    exit 1
    fi
fi