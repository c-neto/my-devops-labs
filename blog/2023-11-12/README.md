# logstash

```bash
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
│       ├── output-json.cfg
│       └── output-rubydebug.cfg
├── docker-compose.yml
└── Makefile
```

## How To Run 

The lab was created to run over `docker`. To set up container configuration use `docker-compose`.

- To setup the environment and follow up the logstash container logs.

```bash
$ make up
```

- To destroy the environment.

```bash
$ make down
```

