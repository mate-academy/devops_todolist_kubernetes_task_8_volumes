#!/bin/bash

echo "📦 Applying PersistentVolume..."
kubectl apply -f pv.yml

echo "📦 Applying PersistentVolumeClaim..."
kubectl apply -f pvc.yml

echo "🔧 Applying ConfigMap..."
kubectl apply -f confgiMap.yml  # з помилкою, так як вимагає таска

echo "🔐 Applying Secret..."
kubectl apply -f secret.yml

echo "🚀 Applying Deployment..."
kubectl apply -f deployment.yml
