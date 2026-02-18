#!/bin/bash

# Navigate to infrastructure directory
cd ./.infrastructure

# 1. Apply Storage Resources (PV must exist before PVC)
kubectl apply -f pv.yml
kubectl apply -f pvc.yml

# 2. Apply Configuration and Secrets
kubectl apply -f secret.yml
kubectl apply -f configMap.yml

# 3. Apply Networking
kubectl apply -f clusterIp.yml
kubectl apply -f nodeport.yml

# 4. Apply Workload and Scaling
kubectl apply -f deployment.yml
kubectl apply -f hpa.yml

echo "Deployment sequence completed."