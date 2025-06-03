#!/bin/bash

# Вихід при помилці
set -e

# Створення namespace, якщо не існує
kubectl get namespace mateapp || kubectl create namespace mateapp

echo "📦 Applying PersistentVolume..."
kubectl apply -f pv.yml

echo "📦 Applying PersistentVolumeClaim..."
kubectl apply -f pvc.yml

echo "📦 Applying ConfigMap..."
kubectl apply -f configMap.yml

echo "🔐 Applying Secret..."
kubectl apply -f secret.yml

echo "🚀 Deploying Application..."
kubectl apply -f deployment.yml

echo "✅ All resources have been deployed successfully."
