#!/usr/bin/env bash
set -euo pipefail

# Create namespace if missing
kubectl create namespace todoapp --dry-run=client -o yaml | kubectl apply -f -

# Apply resources
kubectl apply -f .infrastructure/confgiMap.yml
kubectl apply -f .infrastructure/secret.yml
kubectl apply -f pv.yml
kubectl apply -f pvc.yml
kubectl apply -f deploy.yml

# Wait for deployment rollout
kubectl -n todoapp rollout status deployment/mate --timeout=120s
kubectl -n todoapp get pods -l app=mate-app -o wide

# Quick validation commands (uncomment to run)
# POD=$(kubectl -n todoapp get pods -l app=mate-app -o jsonpath='{.items[0].metadata.name}')
# kubectl -n todoapp exec -it "$POD" -- ls -l /app/configs
# kubectl -n todoapp exec -it "$POD" -- ls -l /app/secrets
# kubectl -n todoapp exec -it "$POD" -- ls -ld /app/data
