#!/bin/bash

# Create todoapp namespace
kubectl create namespace todoapp

# Apply ConfigMap and Secret
kubectl apply -f configMap.yml
kubectl apply -f secret.yml

# Apply PersistentVolume and PersistentVolumeClaim
kubectl apply -f pv.yml
kubectl apply -f pvc.yml

# Apply Deployment
kubectl apply -f deployment.yml
