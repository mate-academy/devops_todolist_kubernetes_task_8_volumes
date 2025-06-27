#!/bin/bash

echo "Створення PersistentVolume..."
kubectl apply -f pv.yml

echo "Створення PersistentVolumeClaim..."
kubectl apply -f pvc.yml

echo "Створення ConfigMap..."
kubectl apply -f configmap.yml

echo "Створення Secret..."
kubectl apply -f secret.yml

echo "Створення Deployment..."
kubectl apply -f deployment.yml

echo "Створення Service..."
kubectl apply -f service.yml

echo "Розгортання завершено!"
echo "Зачекайте кілька секунд, доки LoadBalancer отримає зовнішній IP, потім виконайте 'kubectl get service todo-app-service' щоб отримати IP."