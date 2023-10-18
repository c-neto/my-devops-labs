from threading import Thread
from time import sleep
import random

import prometheus_client as prometheus

STATES = ['starting', 'running', 'stopped']

enum = prometheus.Enum(
    'python_app_custom_enum', 'Description of enum',
    states=STATES
)

counter = prometheus.Counter(
    'python_app_custom_counter', 'Description of counter'
)

info = prometheus.Info(
    'python_app_custom_info', 'Description of info'
)

gauge = prometheus.Gauge(
    'python_app_custom_gauge', 'Description of gauge'
)


summary = prometheus.Summary(
    'python_app_custom_summary', 'Description of summary'
)
summary.observe(10)


counter_with_labels = prometheus.Counter(
    'python_app_custom_counter_with_labels', 'HTTP Failures', ['method', 'endpoint']
)
counter_with_labels.labels('get', '/')
counter_with_labels.labels('post', '/')


def counter_with_labels_handler():
    global counter_with_labels
    while True:
        counter_with_labels.labels(method='get', endpoint='/').inc(1)
        counter_with_labels.labels(method='post', endpoint='/').inc(1)
        sleep(1)


def gauge_handler():
    global gauge
    gauge.set(500)

    while True:
        gauge.inc(random.randint(5, 15))
        gauge.dec(random.randint(1, 10))
        sleep(5)


def info_handler():
    global info
    while True:
        info.info(
            {
                'version': '1.2.3',
                'buildhost': 'foo@bar'
            }
        )
        sleep(3)


def enum_handler():
    global enum
    while True:
        for state in STATES:
            enum.state(state)
            sleep(3)


def counter_handler():
    global counter
    while True:
        counter.inc(2)
        sleep(1)


if __name__ == '__main__':
    Thread(target=counter_handler).start()
    Thread(target=enum_handler).start()
    Thread(target=info_handler).start()
    Thread(target=gauge_handler).start()
    Thread(target=counter_with_labels_handler).start()

    prometheus.start_http_server(8000)

    while True:
        pass
