#!/bin/bash

# Create Namespace
kubectl apply -f .infrastructure/namespace.yml

# Create PersistentVolume
kubectl apply -f .infrastructure/pv.yml

# Create PersistentVolumeClaim
kubectl apply -f .infrastructure/pvc.yml

# Create ConfigMap
kubectl apply -f .infrastructure/configMap.yml

# Create Secret
kubectl apply -f .infrastructure/secret.yml

# Create services: ClusterIp, Nodeport, hpa
kubectl apply -f .infrastructure/clusterIp.yml
kubectl apply -f .infrastructure/nodeport.yml
kubectl apply -f .infrastructure/hpa.yml

# Run Deployment
kubectl apply -f .infrastructure/deployment.yml
