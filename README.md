## Schedule example

Example of hooks with schedule bindings. 6 fields for crontab are used.

### run

Build shell-operator image with custom scripts:

```bash
$ export current_tag=0.0.1
$ podman build -t "docker.io/sadhal/shell-operator-k8s-reconciler:${current_tag}" .
$ podman push docker.io/sadhal/shell-operator-k8s-reconciler:${current_tag}
```

Edit image in shell-operator-deployment.yaml and apply manifests:

```bash
$ kubectl create ns appinfra-k8s-reconciler
$ kubectl -n appinfra-k8s-reconciler apply -f shell-operator-rbac.yaml
$ oc adm policy add-scc-to-user anyuid -z shell-operator-k8s-reconciler -n appinfra-k8s-reconciler
$ kubectl -n appinfra-k8s-reconciler apply -f shell-operator-deployment-ns-cluster-0.yaml
$ kubectl -n appinfra-k8s-reconciler apply -f shell-operator-deployment-argocd-cluster-0.yaml
```

See in logs that crontab-6-fields.sh was run.
```bash
$ podNameNamespace=`kubectl -n appinfra-k8s-reconciler get pods -l gits.reconcile.type=namespace -o jsonpath='{.items[*].metadata.name}'`
$ kubectl -n appinfra-k8s-reconciler logs $podNameNamespace
$ podNameArgoCD=`kubectl -n appinfra-k8s-reconciler get pods -l gits.reconcile.type=argocd -o jsonpath='{.items[*].metadata.name}'`
$ kubectl -n appinfra-k8s-reconciler logs $podNameArgoCD
```


### cleanup

```bash
$ kubectl delete ns/appinfra-ns-reconciler
$ podman rmi docker.io/sadhal/shell-operator-ns-reconciler:${current_tag}
```
