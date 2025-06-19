import hashlib

log_line_in_string = "2025-06-19T17:02:35.123456789Z stdout F This is a Foobar application log sample running in kubernetes persisted on /var/log/containers/*.log"

log_line_in_bytes = log_line_in_string.encode("utf-8")
log_line_in_sha256_hexa_decimal = hashlib.sha256(log_line_in_bytes).hexdigest()

print(log_line_in_sha256_hexa_decimal)
# >>> "19a93f55808eb5478c65813c028045f1b354abe12790eb8aee0dd825697aa93e"
