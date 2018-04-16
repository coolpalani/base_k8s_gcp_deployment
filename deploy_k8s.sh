#!/usr/bin/env bash

CLUSTER_NAME_IS_DATE="cluster-$(date +%Y-%m-%d)"

# Deploy kubernetes cluster
# Specify number of nodes, default = 3
if [ $1 ]
then
    NUM_NODES=$1
else
    NUM_NODES=3
fi

# Start cluster
gcloud container clusters create --num-nodes=$NUM_NODES $CLUSTER_NAME_IS_DATE

# Create/Map secrets on cluster
kubectl create secret generic access-token-env --from-literal=ACCESS_TOKEN=ACCESS_TOKEN
kubectl create secret generic account-id-env --from-literal=ACCOUNT_ID=ACCOUNT_ID