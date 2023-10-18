# lab-opensearch

Docker Compose Lab created to test [OpeSearch-Dashboards Multi Data Sources](https://opensearch.org/docs/latest/dashboards/discover/multi-data-sources/) feature.


> This lab was created based on the following [opensearch-project/OpenSearch-Dashboards](https://github.com/opensearch-project/OpenSearch-Dashboards) Issue:
> - https://github.com/opensearch-project/OpenSearch-Dashboards/issues/4529

---

Project directory layout:

```bash
├── docker-compose.yml          # opensearch-stack containers manifest
├── generate-certificates.sh    # script to generate self-signed certificates in '_certs/' folder 
├── data-source-export.ndjson   # opensearch-dashboards data sources connections objects exported (need to be updated manually in OpenSearch-Dashboards > Stack Management > Saved objects > Import)
├── Makefile                    # script to configure opensearch-stack containers (certificates + docker-compose up)
├── _certs                      # self-signed certificates created by 'generate-certificates.sh' script
│   └── ...
├── opensearch-dashboards       # opensearch-dashboards configuration 
│   └── ...
├── opensearch-main             # opensearch configuration (Primary)
│   └── ...
└── opensearch-secondary        # opensearch configuration (Secondary)
    └── ...
```

## How To Run 

- To start the environment:

```bash
$ make up
# waiting 1 minute to wait containers boot...
```

- To destroy stack:

```bash
$ make down
```

## How to Access the OpenSearch and OpenSearch-Dashboards

The resources can be accessed with the following links:

- **OpenSearch-Dashboards:**
  - Host URL: https://127.0.0.1:5601/
  - Container Name: `opensearch-dashboards.lab`
  - User: `admin`
  - Pasword: `admin`
  - OpenSearch Primary Connection: `https://opensearch-main.lab:9200`
- **OpenSearch MAIN:**
  - Host URL: https://127.0.0.1:9200/
  - Container Name: `opensearch-main.lab`
  - Configured as OpenSearch-Dashboard Primary Connection.
  - Admin User: `admin`
  - Admin Pasword: `admin`
- **OpenSearch SECONDARY:**
  - Host URL: https://127.0.0.1:9201/
  - Container Name: `opensearch-secondary.lab`
  - Created to be Configured in the Data Source in OpenSearch-Dashboards
  - Admin User: `admin`
  - Admin Pasword: `admin`

## How To Import Data Source Configuration

How to Configure Data Source:

- Access the menu _[OpenSearch-Dashboards > Stack Management > Saved objects > Import](http://127.0.0.1:5601/app/management/opensearch-dashboards/objects)_
- Upload the file [lab-opensearch/multi-data-source-bug/data-source-export.ndjson](/multi-data-source-bug/data-source-export.ndjson
- Test data sources connections in _[OpenSearch-Dashboards > Stack Management > Data Sources](http://127.0.0.1:5601/app/management/opensearch-dashboards/dataSources)_
