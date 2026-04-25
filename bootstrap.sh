#!/bin/bash

echo "--- Deploying TodoApp Infrastructure ---"

# 1. Створюємо оточення
kubectl apply -f .infrastructure/namespace.yml

# 2. Створюємо сховище (PV та PVC)
kubectl apply -f .infrastructure/pv.yml
kubectl apply -f .infrastructure/pvc.yml

# 3. Створюємо конфігурації
kubectl apply -f .infrastructure/configMap.yml
kubectl apply -f .infrastructure/secret.yml

# 4. Запускаємо сервіси та застосунок
kubectl apply -f .infrastructure/clusterIp.yml
kubectl apply -f .infrastructure/nodeport.yml
kubectl apply -f .infrastructure/deployment.yml

echo "--- Deployment finished! ---"
kubectl get pods -n todoapp
