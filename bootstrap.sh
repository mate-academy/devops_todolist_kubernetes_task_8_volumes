#!/bin/bash 

files=("namespace.yml" "configMap.yml" "secret.yml" "pv.yml" "pvc.yml" "deployment.yml" "nodeport.yml" "clusterIp.yml" "hpa.yml") 

for file in "${files[@]}"; do
    kubectl apply -f .infrastructure/$file
done
