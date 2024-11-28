#!/bin/bash

# Create namespace
kubectl apply -f .infrastructure/namespace.yml

# Apply PersistentVolume
kubectl apply -f .infrastructure/pv.yml


# Apply PersistentVolumeClaim
kubectl apply -f .infrastructure/pvc.yml -n todoapp

# Apply ConfigMap
kubectl apply -f .infrastructure/configmap.yml -n todoapp

# Apply Secret
kubectl apply -f .infrastructure/secret.yml -n todoapp

# Apply Deployment
kubectl apply -f .infrastructure/deployment.yml -n todoapp

# Apply Service
kubectl apply -f .infrastructure/nodeport.yml -n todoapp

echo "All resources have been deployed successfully."
