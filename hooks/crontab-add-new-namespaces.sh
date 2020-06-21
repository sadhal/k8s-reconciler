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

  git clone --depth=1 https://github.com/sadhal/tenant-x.git /tenant-x
  cd /tenant-x
  echo `pwd`
  echo "commit: `git log -n 1`";
  echo "working in cluster: $CLUSTER_NAME";
  kustomize_overlay="overlays/$CLUSTER_NAME"
  kubectl apply -k $kustomize_overlay
  cd -
  rm -fr /tenant-x
fi
