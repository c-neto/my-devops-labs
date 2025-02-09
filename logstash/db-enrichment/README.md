# DB Enrichment Project

This project sets up a local environment for enriching logs with data from a PostgreSQL database using Logstash. The setup includes Docker containers for Logstash and PostgreSQL, along with the necessary configuration files and scripts. The purpose of this project is to test JDBC connection string parameters to avoid Logstash's bad behavior when the PostgreSQL table is locked or slow.

The following sections provide detailed instructions on how to set up and use the provided Docker containers, as well as how to send logs for enrichment.

```bash
├── Makefile                    # Docker-compose shortcut (up|down)
├── docker-compose.yaml         # Docker-compose manifest file
├── logstash
│   ├── Dockerfile              # Logstash Dockerfile
│   ├── config
│   │   ├── logstash.yml        # Logstash configuration file
│   │   └── pipelines.yml       # Logstash pipelines configuration
│   └── pipeline
│       └── pipeline.cfg        # Main Logstash pipeline configuration
├── postgres
│   └── init.sql                # PostgreSQL initialization script
└── send-log.sh                 # Script to send logs to Logstash
```

# Set up the containers

To start the containers, use the following command:

```bash
make up
```

To stop the containers, use the following command:

```bash
make down
```

# Send logs

The script [send-log.sh](./send-log.sh) is used to send logs to Logstash through HTTP. There are two types of logs: enriched logs and non-enriched logs.

To send logs that will be enriched from the database, use the following command:

```shell
./send-log.sh db
```

To send logs that will not be enriched, use the following command:

```shell
./send-log.sh
```

# JDBC String Connection Details

More details about JDBC_CONNECTION_STRING parameters:

- https://jdbc.postgresql.org/documentation/use/
- https://www.postgresql.org/docs/current/runtime-config-client.html

JDBC connection string used in this stack:

```
jdbc:postgresql://postgres:5432/db?ApplicationName=logstash&loginTimeout=10&socketTimeout=10&options=-c%20statement_timeout=5000%20-c%20lock_timeout=1000
```

- `ApplicationName=logstash`: Sets the application name to "logstash" for easier identification in PostgreSQL logs.
- `loginTimeout=10`: Specifies the maximum time in seconds to wait for a connection to be established. If the connection cannot be established within this time, an error is thrown.
- `socketTimeout=10`: Sets the maximum time in seconds for reading data from the database. If the database does not respond within this time, the connection is closed.
- `options=-c statement_timeout=5000 -c lock_timeout=1000`: Passes additional configuration parameters to PostgreSQL:
    - `statement_timeout=5000`: Sets the maximum time in milliseconds that a query can run before being terminated. In this case, queries running longer than 5 seconds will be aborted.
    - `lock_timeout=1000`: Sets the maximum time in milliseconds to wait for a lock on a table. If the lock cannot be acquired within 1 second, an error is thrown.

# SQL Command to Lock Table

With auto-commit off, when you execute the command below, the table will be locked. When you commit, the table will be unlocked.

```sql
LOCK TABLE table_users IN ACCESS EXCLUSIVE MODE;
```

# How to Simulate a Slow Query

To test how Logstash handles slow queries, you can simulate a delay in the PostgreSQL response using the `pg_sleep` function. This function pauses the execution for a specified number of seconds. In the example below, the query will sleep for 7 seconds before returning the results.

Use the following SQL command to simulate a slow query:

```sql
SELECT
    pg_sleep(7)::text,
    user_name,
    user_email,
    user_group
FROM table_users
WHERE id = ?
```

In this query:
- `pg_sleep(7)::text` introduces a 7-second delay.
- `user_name`, `user_email`, and `user_group` are the columns being retrieved from the `table_users` table.
- `id = ?` is a placeholder for the user ID you want to query.

This setup helps you observe how Logstash behaves when the database query takes longer to execute.
