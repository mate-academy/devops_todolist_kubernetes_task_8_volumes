#!/bin/bash

set -e

echo "Creating PersistentVolume..."
kubectl apply -f pv.yml

echo "Creating PersistentVolumeClaim..."
kubectl apply -f pvc.yml

echo "Deploying application..."
kubectl apply -f deployment.yml

echo "Waiting for deployment rollout..."
kubectl rollout status deployment/todoapp

echo "Deployment completed successfully."