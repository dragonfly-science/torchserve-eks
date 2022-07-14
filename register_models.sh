#!/usr/bin/env bash

set -ex

echo Register Models with TorchServe
EXTERNAL_IP=`kubectl get svc -n ${NAMESPACE} -o jsonpath='{.items[0].status.loadBalancer.ingress[0].hostname}'`
response=$(curl --write-out %{http_code} --silent --output /dev/null --retry 5 -X POST "http://${EXTERNAL_IP}:8081/models?url=https://torchserve.s3.amazonaws.com/mar_files/resnet-18.mar&initial_workers=1&synchronous=true")

if [ ! "$response" == 200 ]
then
    echo "failed to register model with torchserve"
else
    echo "successfully registered model with torchserve"
fi
