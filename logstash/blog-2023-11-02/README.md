# logstash

```bash
├── docker-compose.yml
├── logstash
│   ├── config
│   │   ├── logstash.yml
│   │   └── pipelines.yml
│   ├── Dockerfile
│   └── pipeline
│       ├── filter-a.cfg
│       ├── filter-b.cfg
│       ├── input-a.cfg
│       ├── input-b.cfg
│       ├── output-a.cfg
│       └── output-b.cfg
└── Makefile
```

## How To Run 

The lab was created to run over `docker`. To set up container configuration use `docker-compose`.

- To start the environment:

```bash
$ docker-compose up --build -d 
```

- To check logs:

```bash
$ docker-compose logs
```

- To destroy stack:

```bash
$ docker-compose logs
```

## How to Access the OpenSearch

The resources can be accessed with the following links:

- OpenSearch Dashboards: http://127.0.0.1:5601/
- OpenSearch: http://127.0.0.1:9200/
