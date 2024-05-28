#!/bin/bash

# Apply the namespace
kubectl apply -f namespace.yml

# Apply the ConfigMap
kubectl apply -f configiMap.yml

# Apply the Secret
kubectl apply -f secret.yml

# Apply the PersistentVolume
kubectl apply -f pv.yml

# Apply the PersistentVolumeClaim
kubectl apply -f pvc.yml

# Apply the ClusterIP service
kubectl apply -f clusterip.yml

# Apply the NodePort service
kubectl apply -f nodeport.yml

# Apply the Deployment
kubectl apply -f deployment.yml

# Apply the Horizontal Pod Autoscaler (HPA)
kubectl apply -f hpa.yml
