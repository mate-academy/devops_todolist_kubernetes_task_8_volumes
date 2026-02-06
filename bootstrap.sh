#!/bin/bash

echo "Starting deployment..."

# 1. Namespace
kubectl apply -f .infrastructure/namespace.yml

# 2. Storage
kubectl apply -f .infrastructure/pv.yml
kubectl apply -f .infrastructure/pvc.yml

# 3. Configs & Secrets (Виправлена назва файлу тут!)
kubectl apply -f .infrastructure/configMap.yml
kubectl apply -f .infrastructure/secret.yml

# 4. App & Network
kubectl apply -f .infrastructure/deployment.yml
kubectl apply -f .infrastructure/service.yml

# 5. Background tasks
kubectl apply -f .infrastructure/hpa.yml
kubectl apply -f .infrastructure/daemonset.yml
kubectl apply -f .infrastructure/cronjob.yml

echo "Deployment completed successfully! Check pods in mateapp namespace."