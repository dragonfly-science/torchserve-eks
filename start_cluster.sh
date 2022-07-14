#!/usr/bin/env bash

set -ex

echo Setting environment variables using .env..
source .env

echo Prepare infrastructure configuration..
bash src/pt_serve_util.sh

echo Create the cluster using eksctl..
eksctl create cluster -f ${K8S_MANIFESTS_DIR}/cluster.yaml

echo Deploy Pods to EKS cluster..
kubectl create namespace ${NAMESPACE}
kubectl -n ${NAMESPACE} apply -f ${K8S_MANIFESTS_DIR}/pt_inference.yaml

echo Showing pods..
kubectl get pods -n ${NAMESPACE}

