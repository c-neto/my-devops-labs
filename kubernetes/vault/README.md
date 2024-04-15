helm repo add hashicorp https://helm.releases.hashicorp.com

helm show values hashicorp/vault


helm install vault hashicorp/vault --set "server.dev.enabled=true"

export VAULT_ADDR="http://127.0.0.1:8200"
export VAULT_TOKEN="root"


```
/var/run/secrets/kubernetes.io/serviceaccount/token
```

```
curl     --request POST     --data '{"jwt": "$TOKEN", "role": "cluster-dev-ro"}'     http://192.168.1.81:8200/v1/auth/cluster-dev/login
```

```
k port-forward svc/vault 8200:8200 --address='0.0.0.0'
```
