#!/bin/bash
#
# This script checks the health status of an OpenSearch cluster and its node.
# If the cluster is not yet ready, it waits for it to become ready.
# Once the cluster is ready, it checks the health status of the local node.
#
# >>> reference: https://github.com/elastic/helm-charts/blob/main/elasticsearch/templates/statefulset.yaml#L238

set -e

OPENSEARCH_USERNAME=
OPENSEARCH_PASSWORD=

OPENSEARCH_CLUSTER_API_URL="https://svc-os-cluster-manager:9200"
OPENSEARCH_NODE_API_URL="https://127.0.0.1:9200"

CHECKPOINT_FILE_OPENSEARCH_CLUSTER_HEALTHY=/tmp/.checkpoint_file_opensearch_cluster_healthy


# Function to check the health status of the OpenSearch cluster
check_cluster_health_status() {
  curl -XGET -k --fail --output /dev/null \
    -u "${OPENSEARCH_USERNAME}:${OPENSEARCH_PASSWORD}" \
    "$OPENSEARCH_CLUSTER_API_URL/_cluster/health?wait_for_status=green&timeout=1s"
}

# Function to check the health status of the local OpenSearch node
check_node_health_status() {
  HTTP_CODE=$(
    curl -XGET -k -s --fail --output /dev/null \
      -w %{http_code} \
      -u "${OPENSEARCH_USERNAME}:${OPENSEARCH_PASSWORD}" \
      "$OPENSEARCH_NODE_API_URL"
  )

  if [[ "${HTTP_CODE}" == "200" ]]; then
    echo "Node is healthy"
    exit 0
  else
    echo "Node health check failed with HTTP code ${HTTP_CODE}"
    exit 1
  fi
}

main() {
  # Check if OpenSearch is already running and then check the local node health
  if [ -f "${CHECKPOINT_FILE_OPENSEARCH_CLUSTER_HEALTHY}" ]; then
    echo "OpenSearch is already running, let's check the node health"
    check_node_health_status
  else
    echo "OpenSearch cluster is ready, but node health check skipped (not yet running)"
  fi

  # Check if the OpenSearch cluster is already healthy
  if check_cluster_health_status; then
    touch "${CHECKPOINT_FILE_OPENSEARCH_CLUSTER_HEALTHY}"
    echo "OpenSearch cluster is ready"
  else
    echo "Waiting for OpenSearch cluster to become ready"
    exit 1
  fi
}

main
