# Fluent Bit Log Hashing Example

> [!NOTE]  
> This lab is part of the blog post:
> - https://carlosneto.dev/blog/2025/2025-06-19-fluentbit-log-dedup/


This lab demonstrates how to use Fluent Bit to process log lines, generate a hash for each log entry, and output the results. This is useful for anonymizing or deduplicating logs, especially in Kubernetes environments where logs are persisted in `/var/log/containers/*.log`.

```bash
├── docker-compose.yml      # Runs Fluent Bit in a container using the provided configuration.
├── fluent-bit.yaml         # Fluent Bit pipeline configuration
└── hash-process-sample.py  # Python script that demonstrates how to hash a log line using SHA-256, matching the logic in the Fluent Bit pipeline.
```

## Running the Lab

```sh
docker compose up --watch
```

You should see output similar to:

```json
{"message":"2025-06-19T17:02:35.123456789Z stdout F This is a Foobar application log sample running in kubernetes persisted on /var/log/containers/*.log","_id":"19a93f55808eb5478c65813c028045f1b354abe12790eb8aee0dd825697aa93e"}
```

## Hash Verification

You can verify the hash using the provided Python script:

```sh
python3 hash-process-sample.py
```

The output should match the `_id` field in the Fluent Bit output.

## References

- [Fluent Bit Documentation](https://docs.fluentbit.io/)
