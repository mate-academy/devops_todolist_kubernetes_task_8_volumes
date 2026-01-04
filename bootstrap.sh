#!/bin/sh
set -e

kubectl create namespace todoapp || true
kubectl create namespace mateapp || true

kubectl apply -f .infrastructure/configMap.yml
kubectl apply -f .infrastructure/secret.yml

kubectl apply -f .infrastructure/pv.yml
kubectl apply -f .infrastructure/pvc.yml

kubectl apply -f .infrastructure/deployment.yml
kubectl apply -f .infrastructure/daemonset.yml
kubectl apply -f .infrastructure/cronjob.yml

kubectl get all -n todoapp
kubectl get all -n mateapp
kubectl get pv
kubectl get pvc -n todoapp
