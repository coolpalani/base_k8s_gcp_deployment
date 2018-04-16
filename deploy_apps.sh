#!/usr/bin/env bash

nodenames=("redis" "demo_app")
#nodenames=("demo_app")

# Load secrets
secrets_array=()
for i in ${nodenames[@]}; do
        echo "Extracting $i app configuration..."
        varsarr=$(cat app_configs.json | jq --arg v "$i" '.applications[] | select(.name == $v)' | jq '.base_env_vars[]')
        if [[ ${varsarr} ]]; then
            for var in ${varsarr}; do
                secrets_array+=($(sed -e 's/^"//' -e 's/"$//' <<<"$var"))
            done
        fi
done

# Deployments
for i in ${nodenames[@]}; do
        # Extract deployment path from app configuration, prepend current directory path
        rawdeploypath=$(cat app_configs.json | jq --arg v "$i" '.applications[] | select(.name == $v)' | jq '.k8s_deployment')
        deploymentpath=$(sed -e 's/^"//' -e 's/"$//' <<<"$rawdeploypath")
        CURRDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
        deployment=$CURRDIR/$deploymentpath

        # Deploy app into k8s cluster
        echo -e "\nDeploying $i to k8s from ...$deployment"
        kubectl create -f $deployment
done
