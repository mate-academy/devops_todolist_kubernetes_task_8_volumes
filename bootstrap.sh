#!/bin/bash

set -e  # Exit immediately if a command fails
set -o pipefail  # Catch errors in pipelines
set -x  # Print commands for debugging

echo "Creating Namespace..."
kubectl apply -f namespace.yml

echo "Applying ConfigMap..."
kubectl apply -f configMap.yml

echo "Applying Secrets..."
kubectl apply -f secret.yml

echo "Creating PersistentVolume..."
kubectl apply -f pv.yml

echo "Creating PersistentVolumeClaim..."
kubectl apply -f pvc.yml

echo "Creating ClusterIP Service..."
kubectl apply -f clusterIp.yml

echo "Creating NodePort Service..."
kubectl apply -f nodeport.yml

echo "Deploying application..."
kubectl apply -f deployment.yml

echo "Applying Horizontal Pod Autoscaler (HPA)..."
kubectl apply -f hpa.yml

echo "All resources have been successfully deployed!"
