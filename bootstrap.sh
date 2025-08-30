#!/usr/bin/env bash
set -euo pipefail

NS=mateapp

echo ">> Ensure namespace"
kubectl create namespace "$NS" 2>/dev/null || true

echo ">> Apply ConfigMap & Secret"
kubectl -n "$NS" apply -f .infrastructure/configMap.yml
kubectl -n "$NS" apply -f .infrastructure/secret.yml

echo ">> Apply PV/PVC"
kubectl apply -f .infrastructure/pv.yml
kubectl -n "$NS" apply -f .infrastructure/pvc.yml

echo ">> Apply Deployment"
kubectl -n "$NS" apply -f .infrastructure/deployment.yml

echo ">> Wait for rollout"
kubectl -n "$NS" rollout status deploy/todoapp

echo "Done."
