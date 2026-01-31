#!/bin/bash

# Apply namespace
kubectl apply -f .infrastructure/namespace.yml

# Apply ConfigMap
kubectl apply -f .infrastructure/configMap.yml

# Apply Secrets
kubectl apply -f .infrastructure/secret.yml

# Apply PersistentVolume
kubectl apply -f .infrastructure/pv.yml

# Apply PersistentVolumeClaim
kubectl apply -f .infrastructure/pvc.yml

# Apply Deployment
kubectl apply -f .infrastructure/deployment.yml

# Apply Horizontal Pod Autoscaler
kubectl apply -f .infrastructure/hpa.yml

# Apply NodePort Service
kubectl apply -f .infrastructure/nodeport.yml

# Apply ClusterIP Service
kubectl apply -f .infrastructure/clusterIp.yml
