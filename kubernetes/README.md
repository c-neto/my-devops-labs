# kubernetes-playground

My K8S Kubernetes playground :rocket:

## Install Rancher Desktop on Fedora 35

```bash
$ yum update -y 
```

Download yum repo file of the Rancher Desktop:

```bash
$ curl https://download.opensuse.org/repositories/isv:/Rancher:/stable/rpm/isv:Rancher:stable.repo -o /etc/yum.repos.d/_rancher-desktop.repo 
```

Install Fedora virtualizations drivers:

```bash
$ dnf install @virtualization -y
$ dnf group install --with-optional virtualization
$ systemctl start libvirtd
$ systemctl enable libvirtd
```

Update yum cache

```bash
$ yum makecache
```

Install rancher-desktop

```bash
$ yum install rancher-desktop
```

## Cheat Sheet

List contexts

```bash
kubectl kubecconfig get-contexts
```

Change context

```bash
kubectx <context-name>
```

Get nodes

```bash
kubectl get nodes
```

Get more information

```bash
kubectl get nodes -o json -o wide
```

Get value with JSONPath sytax

```bash
kubectl get nodes minikube -o jsonpath --template={.spec.podCIDR} 
```

Resource hot edit 

```bash
kubectl edit <resource> <object-name>
```

Resources label

```bash
kubectl label pods bar color=red
kubectl label pods bar color=blue --overwrite
kubectl label pods bar color-
```

List containers in POD

```bash
kubectl get pods <pod-name> -o jsonpath='{.spec.containers[*].name}'
```

View container log in POD

```bash
kubectl logs <pod-name> -c <container-name> -f
```

Exec command in containers

```bash
kubectl exec -it <pod-name> -- bash
```

Follow main process in POD (like logs, but with stdin available)

```bash
kubectl attach -it <pod-name>
```

Copy files to and from pod

```bash
kubectl <pod-name>:/var/local/xtpo /home/user/
```

Expose POD ports

```bash
kubectl port-forward <pod-name> 8080:80 
```

Expose SERVICE ports

```bash
kubectl port-forward services/<service-name> 
```

Get ReplicaSet details

```bash
kubectl describe rs kuard
```

Check POD owner references

```bash
kubectl get pods <pod> -o yaml | grep -A 10 ownerReferences
```

Scale Replicas (imperative way)

```bash
kubectl scale replicaset <replicaset> --replicas=4 
```

Enable Autoscale (HPA), 2..5 replicas by 80% cpu usage

```bash
kubectl autoscale rs kuard --min=2 --max=5 --cpu-percent=80
```

Get deployment labels

```bash
kubectl get deployments kuard -o jsonpath --template {.spec.selector.matchLabels}
```

Filter Replica Set by label

```bash
kubectl get replicasets -l run=kuard
```

Backup deployment

```bash
kubectl get deployment <deployment-name> -o yaml > bkp-deploy.yaml
kubectl replace -f <deployment-file .yml> --save-config
```

Get rollout history

```bash
kubectl rollout history deployment kuard 
```

> To add change cause, add value to `spec.template.metadata.annotations.kubernetes.io/change-cause`

Get rollout informations of the specific version

```bash
kubectl rollout history deployment kuard --revision=2
```

Undo rollout

```bash
kubectl rollout undo deployments kuard
```

Rollout to specific version

```bash
kubectl rollout undo deployment kuard --to-revision=3
```