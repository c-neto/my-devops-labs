https://medium.com/@hajsanad/kubernetes-token-review-and-authentication-56e06cc55ed3
https://wlwan.medium.com/why-a-cluster-role-binding-is-needed-in-k8s-vault-integration-82b5aefc4d81


kubectl proxy --port=8081

/var/run/secrets/kubernetes.io/serviceaccount/token

curl -X POST http://<service-ip>/validate-token -H "Content-Type: application/json" -d '{"token": "YOUR_TOKEN_HERE"}'

k exec -it flask-app-deployment-bccbb56f4-5m6qm -- cat /var/run/secrets/kubernetes.io/serviceaccount/token

