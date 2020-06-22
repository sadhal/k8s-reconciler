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
  echo "Message from 'crontab-reconcile-k8s-manifest' hook with 6 fields crontab: $binding"

  git clone --depth=1 $GIT_REPO /myfolder
  cd /myfolder
  echo `pwd`
  echo "commit: `git log -n 1`";
  echo "working in cluster: $KUSTOMIZE_OVERLAY_PATH";
  kustomize_overlay="$KUSTOMIZE_OVERLAY_PATH"
  kubectl apply -k $kustomize_overlay
  cd -
  rm -fr /myfolder
fi
