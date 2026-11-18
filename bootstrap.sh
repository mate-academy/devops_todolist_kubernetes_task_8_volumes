#!/usr/bin/env bash
# Deploys all ToDo app resources into the cluster.
# Usage: bash bootstrap.sh   (run from the repository root)
set -euo pipefail

DIR=".infrastructure"

# 1. Namespace first - everything else lives in it
kubectl apply -f "$DIR/namespace.yml"

# 2. Storage: PersistentVolume (cluster-scoped) then the claim
kubectl apply -f "$DIR/pv.yml"
kubectl apply -f "$DIR/pvc.yml"

# 3. Configuration and secrets (must exist before the Deployment starts)
kubectl apply -f "$DIR/configMap.yml"
kubectl apply -f "$DIR/secret.yml"

# 4. Application
kubectl apply -f "$DIR/deployment.yml"

# 5. Networking and autoscaling
kubectl apply -f "$DIR/clusterIp.yml"
kubectl apply -f "$DIR/nodeport.yml"
kubectl apply -f "$DIR/hpa.yml"

# 6. Wait until the rollout is finished
kubectl rollout status deployment/todoapp -n todoapp --timeout=180s

kubectl get all,pvc,configmap,secret -n todoapp
