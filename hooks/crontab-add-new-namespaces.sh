#!/usr/bin/env bash

if [[ $1 == "--config" ]] ; then
  cat <<EOF
{
  "configVersion":"v1",
  "schedule": [
    {
      "name": "every 5 min",
      "crontab": "0 */5 * * * *"
    }
  ]
}
EOF
else
  binding=$(cat $BINDING_CONTEXT_PATH)
  echo "Message from 'crontab-add-new-namespaces' hook with 6 fields crontab: $binding"

  git clone https://github.com/sadhal/tenant-x.git
  echo "commit: " `git log -n 1 --pretty=format:"%H"`;
  kubectl apply -k tenant-x/cluster-0
  rm -fr tenant-x
fi
