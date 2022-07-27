#!/usr/bin/env bash

set -ex

echo Register Models with TorchServe
EXTERNAL_IP=`kubectl get svc -n ${NAMESPACE} -o jsonpath='{.items[0].status.loadBalancer.ingress[0].hostname}'`

if [ ! "$response" == 200 ]
then
    echo "failed to register model with torchserve"
else
    echo "successfully registered model with torchserve"
fi

eksctl scale nodegroup --cluster iwk-t2-medium --nodes=5 ng-1 --nodes-min 1 --nodes-max 10
