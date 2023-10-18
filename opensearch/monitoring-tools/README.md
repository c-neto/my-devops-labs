# lab-opensearch

Lab created to test configuration Filebeat, Logstash, and OpenSearch and OpenSearch stack.

The tool's configuration does not have SSL or authentication plugins enabled. This lab was created to test purposes only, don't apply it in your production infrastructure.

Project directory layout:

```bash
├── docker-compose.yml              # containers config state
├── alertmanager                    # provisioned configuration to alert contact policies
│   └── ...
├── grafana                         # provisioned grafana components to view the alerts and explore metrics of the opensearch cluster  
│   └── ...
├── prometheus                      # configuration to scrap opensearch metrics and to provide alerts rules
│   └── ...
├── prometheus-exporter             # exporter metrics from opensearch metrics API endpoints
│   └── ...
├── filebeat                        # filebeat container files
│   ├── Dockerfile                  # filebeat dockerfile
│   ├── filebeat.yml                # filebeat main config file
│   └── log                         # fake log directory (shared like docker volume)
│       └── *.log                   # fake logs 
├── logstash                        # logstash container file
│   ├── config                      # logstash config directory
│   │   ├── logstash.yml            # logstash main config file
│   │   └── pipelines.yml           # pipelines manifest file
│   ├── Dockerfile                  # logstash Dockerfile
│   └── pipeline                    # pipeline directory
│       └── pipeline-1.cfg          # pipeline source code
├── opensearch                      # opensearch container config files
│   ├── Dockerfile                  # opensearch Dockerfile 
│   └── opensearch.yml              # opensearch main config file 
└── opensearch-dashboards           # opensearch-dashboards container config files
    ├── Dockerfile                  # opensearch-dashboards Dockerfile
    └── opensearch_dashboards.yml   # opensearch-dashboards main config file
```

## How To Run 

The lab was created to run over `docker`. To set up container configuration use `docker-compose`.

```bash
$ docker-compose up --build -d 
```

To check logs, run:

```bash
$ docker-compose logs
```

The resources can be accessed with the following links:

- OpenSearch Dashboards: http://127.0.0.1:5601/
- OpenSearch: http://127.0.0.1:9200/
- Grafana: http://127.0.0.1:3000/
- OpenSearch Prometheus Exporter: http://127.0.0.1:9114
- Prometheus Server: http://127.0.0.1:9090
- Alermanager Console: http://127.0.0.1:9093
- Pruu endpoint (destination of the alerts from alertmanager): https://pruu.herokuapp.com/dump/augustoliks-lab-opensearch

## Cheat Sheet

Test Logstash configuration syntax:

```bash
$ bin/logstash -f first-pipeline.conf --config.test_and_exit
```

---

Install `localstack` CLI and created Bucket:

```bash
$ python3 -m venv venv
$ venv/bin/pip3 install -r awscli-local localstack
$ awslocal s3api create-bucket --bucket sample-bucket 
$ awslocal s3 ls sample-bucket
```

## References

- Generate certificates
> - https://opensearch.org/docs/latest/security-plugin/configuration/generate-certificates/

- Parsing Logs with Logstash
> - https://www.elastic.co/guide/en/logstash/current/advanced-pipeline.html

- Prometheus Alert Rules to OpenSearch/Elasticsearch
> - https://github.com/prometheus-community/elasticsearch_exporter/blob/master/examples/prometheus/elasticsearch.rules.yml
> - https://awesome-prometheus-alerts.grep.to/rules.html#elasticsearch-1
> - https://github.com/dcos/prometheus-alert-rules/blob/master/rules/elasticsearch/elasticsearch.yml

- OpenSearch/ElasticSearch Prometheus Exporter
> - https://github.com/prometheus-community/elasticsearch_exporter
