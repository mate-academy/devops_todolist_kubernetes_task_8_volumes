#!/bin/bash
set -e

echo "=== Applying PersistentVolume ==="
kubectl apply -f pv.yml

echo "=== Applying PersistentVolumeClaim ==="
kubectl apply -f pvc.yml

echo "=== Applying all infrastructure resources (Deployment, ConfigMap, Secret, etc.) ==="
kubectl apply -f .infrastructure/