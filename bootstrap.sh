#!/bin/bash

set -e


# BOOTSTRAP SCRIPT
# Deploy all required Kubernetes resources

echo "Creating namespaces (if not exist)..."
kubectl create namespace todoapp || true
kubectl create namespace mateapp || true


echo "Applying ConfigMap..."
kubectl apply -f configMap.yml

echo "Applying Secret..."
kubectl apply -f secret.yml


echo "Applying PersistentVolume..."
kubectl apply -f pv.yml

echo "Applying PersistentVolumeClaim..."
kubectl apply -f pvc.yml


echo "Applying Deployment..."
kubectl apply -f deployment.yml


echo "Applying DaemonSet..."
kubectl apply -f daemonset.yml


echo "Applying CronJob..."
kubectl apply -f cronjob.yml


echo "Deployment completed"

echo "Current resources status:"
kubectl get all -n todoapp
kubectl get all -n mateapp
kubectl get pv
kubectl get pvc -n mateapp
