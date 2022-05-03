#!/bin/bash



helm repo add projectcalico https://docs.projectcalico.org/charts  --force-update
helm repo update --fail-on-repo-update-fail
helm install calico projectcalico/tigera-operator --version $CALICO_VERSION
