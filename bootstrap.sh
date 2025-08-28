#!/bin/bash

set -e

# Create namespace
kubectl apply -f .infrastructure/namespace.yml

# Create PersistentVolume and PersistentVolumeClaim
kubectl apply -f .infrastructure/pv.yml
kubectl apply -f .infrastructure/pvc.yml

# Create ConfigMap and Secret
kubectl apply -f .infrastructure/configMap.yml
kubectl apply -f .infrastructure/secret.yml

# Deploy the application
kubectl apply -f .infrastructure/deployment.yml

# Optionally, apply Service and HPA if present
kubectl apply -f .infrastructure/clusterIp.yml || true
kubectl apply -f .infrastructure/hpa.yml || true
kubectl apply -f .infrastructure/nodeport.yml || true