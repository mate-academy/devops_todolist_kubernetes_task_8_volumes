#!/bin/bash

# Create namespace
kubectl apply -f namespace.yml

# Create PV and PVC
kubectl apply -f pv.yml
kubectl apply -f pvc.yml

# Create ConfigMap and Secret
kubectl apply -f configMap.yml
kubectl apply -f secret.yml

# Deploy application
kubectl apply -f deployment.yml
kubectl apply -f clusterIp.yml
kubectl apply -f nodeport.yml
kubectl apply -f hpa.yml
