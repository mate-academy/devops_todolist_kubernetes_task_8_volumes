#!/bin/bash

# Create PersistentVolume
kubectl apply -f .infrastructure/pv.yml

# Create PersistentVolumeClaim
kubectl apply -f .infrastructure/pvc.yml

# Create Deployment
kubectl apply -f .infrastructure/deployment.yml

echo "Resources have been deployed successfully."

