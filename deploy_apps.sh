#!/usr/bin/env bash

nodenames=("redis" "demo_data_app")

# Load secrets
secrets_array=()
for i in ${nodenames[@]}; do
        echo $i
        varsarr=$(cat app_configs.json | jq --arg v "$i" '.applications[] | select(.name == $v)' | jq '.base_env_vars[]')
        if [[ ${varsarr} ]]; then
            for var in ${varsarr}; do
                secrets_array+=($(sed -e 's/^"//' -e 's/"$//' <<<"$var"))
            done
        fi
done

# TODO -- within apps_config.json map deployment k8s secret to a k-v to parse through and launch k8s secrets per app
echo ${secrets_array[0]} ${secrets_array[1]}
for i in ${secrets_array[@]}; do
    echo "Secret loop:"
    echo $i
done

# Deployments
for i in ${nodenames[@]}; do
        echo $i
        rawdeploypath=$(cat app_configs.json | jq --arg v "$i" '.applications[] | select(.name == $v)' | jq '.k8s_deployment')
        deploymentpath=$(sed -e 's/^"//' -e 's/"$//' <<<"$rawdeploypath")
        CURRDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
        deployment=$CURRDIR/$deploymentpath
        echo $deployment
        #kubectl create -f $deployment
done

# jq REF:
# http://www.tothenew.com/blog/how-to-parse-json-by-command-line-in-linux/
# https://stedolan.github.io/jq/manual/#Basicfilters
