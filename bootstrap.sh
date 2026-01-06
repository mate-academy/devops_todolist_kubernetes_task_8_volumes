#!/bin/bash

# 1. Create Namespace (if not exists)
kubectl create namespace todoapp --dry-run=client -o yaml | kubectl apply -f -

# 2. Apply Storage Resources
kubectl apply -f .infrastructure/pv.yml
kubectl apply -f .infrastructure/pvc.yml

# 3. Apply Configuration
kubectl apply -f .infrastructure/configMap.yml
kubectl apply -f .infrastructure/secret.yml

# 4. Apply Application
kubectl apply -f .infrastructure/deployment.yml

echo "Bootstrap finished. Resources applied to 'todoapp' namespace."