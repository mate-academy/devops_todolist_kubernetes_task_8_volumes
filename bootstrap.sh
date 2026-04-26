#!/bin/bash

echo "Deploying namespace..."
kubectl apply -f .infrastructure/namespace.yml

echo "Deploying storage (PV, PVC)..."
kubectl apply -f .infrastructure/pv.yml
kubectl apply -f .infrastructure/pvc.yml

echo "Deploying configs (ConfigMap, Secret)..."
kubectl apply -f .infrastructure/configMap.yml
kubectl apply -f .infrastructure/secret.yml

echo "Deploying application..."
kubectl apply -f .infrastructure/deployment.yml

echo "Deploying services (ClusterIP, Nodeport)..."
kubectl apply -f .infrastructure/clusterIp.yml
kubectl apply -f .infrastructure/nodeport.yml

echo "Deploying HPA..."
kubectl apply -f .infrastructure/hpa.yml

echo "Deployment completed!"
