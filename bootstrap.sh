#!/bin/bash

# 1. Створення Namespace
kubectl apply -f .infrastructure/namespace.yml

# 2. Створення PV та PVC
kubectl apply -f pv.yml
kubectl apply -f pvc.yml

# 3. Створення ConfigMap та Secret
kubectl apply -f .infrastructure/configMap.yml
kubectl apply -f .infrastructure/secret.yml

# 4. Створення Deployment та Сервісів
kubectl apply -f .infrastructure/deployment.yml
kubectl apply -f .infrastructure/clusterIp.yml
kubectl apply -f .infrastructure/nodeport.yml
kubectl apply -f .infrastructure/hpa.yml
