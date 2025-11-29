#!/usr/bin/env bash
set -e

CLUSTER_NAME=todoapp-volumes

echo ">>> 1) Создаём kind-кластер ${CLUSTER_NAME}"
kind create cluster --name "${CLUSTER_NAME}" --config cluster.yml

echo ">>> 2) Применяем namespace"
kubectl apply -f .infrastructure/namespace.yml

echo ">>> 3) Применяем ConfigMap и Secret"
kubectl apply -f .infrastructure/configMap.yml
kubectl apply -f .infrastructure/secret.yml

echo ">>> 4) Применяем PV и PVC"
kubectl apply -f .infrastructure/pv.yml
kubectl apply -f .infrastructure/pvc.yml

echo ">>> 5) Применяем Deployment"
kubectl apply -f .infrastructure/deployment.yml

echo ">>> 6) Применяем сервисы и HPA"
kubectl apply -f .infrastructure/clusterIp.yml
kubectl apply -f .infrastructure/nodeport.yml
kubectl apply -f .infrastructure/hpa.yml

echo ">>> 7) Проверяем ресурсы"
kubectl get pods -n todoapp
kubectl get svc -n todoapp
kubectl get pv
kubectl get pvc -n todoapp

echo "Кластер и ресурсы развернуты."
