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
kubectl create secret generic secret1 --from-literal=SECRET_1=$SECRET_1
kubectl create secret generic secret2 --from-literal=SECRET_2=$SECRET_2

# kubectl exec redis-master-ft9ex env
# kubectl get jobs
# kubectl describe jobs/countdown