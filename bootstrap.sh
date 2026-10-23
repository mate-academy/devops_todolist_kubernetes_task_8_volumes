#!/bin/bash
set -e

# Create namespace
kubectl create namespace todoapp

# Deploy ConfigMap
kubectl apply -f .infrastructure/configMap.yml

# Deploy Secret
kubectl apply -f .infrastructure/secret.yml

# Deploy PersistentVolume
kubectl apply -f .infrastructure/pv.yml

# Deploy PersistentVolumeClaim
kubectl apply -f .infrastructure/pvc.yml

# Deploy application
kubectl apply -f .infrastructure/deployment.yml

# Check PersistentVolume
kubectl get pv

# Check PersistentVolumeClaim
kubectl get pvc -n todoapp

# Check Deployment
kubectl rollout status deployment/todoapp -n todoapp

# Check Pods
kubectl get pods -n todoapp
