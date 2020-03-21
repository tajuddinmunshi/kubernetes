#!/usr/bin/env bash

set -e -o pipefail

TF_OUTPUT=$(cd ../terraform && terraform output -json)
CLUSTER_NAME="$(echo ${TF_OUTPUT} | jq -r .kubernetes_cluster_name.value)"
STATE="s3://$(echo ${TF_OUTPUT} | jq -r .kops_s3_bucket.value)"
export KOPS_STATE_STORE="s3://$(echo ${TF_OUTPUT} | jq -r .kops_s3_bucket.value)"
export KOPS_STATE_STORE=s3://dev-kopsvvvvv
kops toolbox template --name ${CLUSTER_NAME} --values <( echo ${TF_OUTPUT}) --template cluster-template.yaml --format-yaml > cluster.yaml
kops replace -f cluster.yaml --state ${STATE} --name ${CLUSTER_NAME} --force
kops create secret --name tajuddinmunshi.com sshpublickey admin -i /tmp/.ssh/id_rsa.pub
kops update cluster --target terraform --state ${STATE} --name ${CLUSTER_NAME} --out .
kops delete cluster ${CLUSTER_NAME} --yes --state ${STATE}
