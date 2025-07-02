# Fluent Bit Bug Reproduction Lab

This setup is designed to help reproduce and investigate the issue where the filter-as-processor is conditionally ignoring records. You can modify the Fluent Bit configuration files in this directory to test different scenarios.

- [Fluent Bit Documentation](https://docs.fluentbit.io/manual/)
- [Bug Report #10524](https://github.com/fluent/fluent-bit/issues/10524)

## Prerequisites

- [Docker](https://www.docker.com/get-started) installed
- [Docker Compose](https://docs.docker.com/compose/install/) installed

## How to Run

1. Clone this repository:

```sh
git clone https://github.com/c-neto/my-devops-labs.git
cd my-devops-labs/fluentbit/bug-filter-as-processor-conditionally-ignoring
```

2. Start the environment:

```sh
docker-compose up -d
```

3. Check the logs:

```sh
docker-compose logs -f
```
