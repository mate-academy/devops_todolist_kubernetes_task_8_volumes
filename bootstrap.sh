#!/bin/bash

echo "Creating namespace..."
kubectl apply -f ./.infrastructure/namespace.yml

echo "Applying ConfigMap..."
kubectl apply -f ./.infrastructure/confgiMap.yml

echo "Applying Secrets..."
kubectl apply -f ./.infrastructure/secret.yml

echo "Applying Persistent Volume..."
kubectl apply -f ./.infrastructure/pv.yml

echo "Applying Persistent Volume Claim..."
kubectl apply -f ./.infrastructure/pvc.yml

echo "Applying Deployment..."
kubectl apply -f ./.infrastructure/deployment.yml

echo "Applying ClusterIP Service..."
kubectl apply -f ./.infrastructure/clusterIp.yml

echo "Applying NodePort Service..."
kubectl apply -f ./.infrastructure/nodeport.yml

echo "Applying HPA..."
kubectl apply -f ./.infrastructure/hpa.yml

echo "All resources applied successfully."