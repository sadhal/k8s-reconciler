## Schedule example

Example of hooks with schedule bindings. 5 fields and 6 fields for crontab are supported.

### run

Build shell-operator image with custom scripts:

```bash
$ export current_tag=0.0.3
$ podman build -t "docker.io/sadhal/shell-operator-ns-reconciler:${current_tag}" .
$ podman push docker.io/sadhal/shell-operator-ns-reconciler:${current_tag}
```

Edit image in shell-operator-deployment.yaml and apply manifests:

```bash
$ kubectl create ns appinfra-ns-reconciler
$ kubectl -n appinfra-ns-reconciler apply -f shell-operator-rbac.yaml
$ oc adm policy add-scc-to-user anyuid -z shell-operator-ns-reconciler -n appinfra-ns-reconciler
$ kubectl -n appinfra-ns-reconciler apply -f shell-operator-deployment.yaml
```

See in logs that crontab-6-fields.sh was run.
```bash
$ podName=`kubectl -n appinfra-ns-reconciler get pods -o jsonpath='{.items[*].metadata.name}'`
$ kubectl -n appinfra-ns-reconciler logs $podName
```


### cleanup

```bash
$ kubectl delete ns/appinfra-ns-reconciler
$ podman rmi docker.io/sadhal/shell-operator-ns-reconciler:${current_tag}
```
