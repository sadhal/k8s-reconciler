#!/usr/bin/env bash

if [[ $1 == "--config" ]] ; then
  cat <<EOF
{
  "configVersion":"v1",
  "schedule": [
    {
      "name": "every ${RECONCILE_INTERVAL_MINUTES} min",
      "crontab": "0 */${RECONCILE_INTERVAL_MINUTES} * * * *"
    }
  ]
}
EOF
else
  binding=$(cat $BINDING_CONTEXT_PATH)
  echo "Message from 'crontab-add-new-namespaces' hook with 6 fields crontab: $binding"

  git clone https://github.com/sadhal/tenant-x.git
  echo "commit: `git log -n 1 --pretty=format:"%H"`";
  echo "working in cluster: $CLUSTER_NAME";
  kustomize_overlay="tenant-x/overlays/$CLUSTER_NAME"
  kubectl apply -k $kustomize_overlay
  rm -fr tenant-x
fi