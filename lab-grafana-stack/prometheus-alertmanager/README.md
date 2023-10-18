# prometheus-alertmanager

Lab to explore integration between Grafana, Prometheus and Alertmanager.

---

First step, it is necessary provisioning Grafana, Prometheus and Alertmanager:

```bash
$ docker-compose up -d
```

Check the Prometheus alerts in the Grafana Dashboard:
- http://127.0.0.1:3000/alerting/list


Wait the alerting change to the `firing` state, and check alert Webhook sent from Alertmanager to [Pruu](https://pruu.herokuapp.com):
- https://pruu.herokuapp.com/dump/alertmanager-test
