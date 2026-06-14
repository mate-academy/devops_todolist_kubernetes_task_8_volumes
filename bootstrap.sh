#!/bin/bash
set -euo pipefail

mkdir -p /tmp/todoapp-data

kubectl apply -f .infrastructure/namespace.yml
kubectl apply -f .infrastructure/configMap.yml
kubectl apply -f .infrastructure/secret.yml
kubectl apply -f pv.yml
kubectl apply -f pvc.yml
kubectl apply -f .infrastructure/deployment.yml
