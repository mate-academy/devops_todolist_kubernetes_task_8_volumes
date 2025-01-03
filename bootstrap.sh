#!/bin/bash

# Створення namespace для додатку
kubectl create namespace todoapp

# Створення PersistentVolume та PersistentVolumeClaim
kubectl apply -f pv.yml
kubectl apply -f pvc.yml

# Створення ConfigMap та Secret
kubectl apply -f configMap.yml
kubectl apply -f secret.yml

# Створення Deployment
kubectl apply -f deployment.yml

# Очікування запуску поду
echo "Очікування запуску поду..."
kubectl wait --namespace todoapp --for=condition=ready pod --selector=app=todoapp --timeout=120s

echo "Додаток ToDo успішно розгорнуто!"
echo "Ви можете перевірити стан подів за допомогою команди: kubectl get pods -n todoapp"