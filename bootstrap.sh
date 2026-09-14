#!/bin/bash
set -e

NAMESPACE="mateapp"

echo "Creating namespace '${NAMESPACE}' if it doesn't exist..."
kubectl create namespace ${NAMESPACE} --dry-run=client -o yaml | kubectl apply -f -

echo "Applying ConfigMap..."
kubectl apply -f .infrastructure/configMap.yml -n ${NAMESPACE}

echo "Applying Secret..."
kubectl apply -f .infrastructure/secret.yml -n ${NAMESPACE}

echo "Applying PersistentVolume..."
kubectl apply -f .infrastructure/pv.yml

echo "Applying PersistentVolumeClaim..."
kubectl apply -f .infrastructure/pvc.yml -n ${NAMESPACE}

echo "Applying Deployment..."
kubectl apply -f .infrastructure/deployment.yml -n ${NAMESPACE}

echo "Waiting for Deployment rollout to complete..."
kubectl rollout status deployment/todoapp -n ${NAMESPACE} --timeout=120s

echo "All resources deployed successfully!"