#!/bin/bash
kubectl apply -f .infrastructure/namespace.yml
kubectl apply -f .infrastructure/pv.yml
kubectl get pv todoapp-pv 
kubectl apply -f .infrastructure/pvc.yml
kubectl apply -f .infrastructure/deployment.yml
kubectl apply -f .infrastructure/service.yml
kubectl get svc -n todoapp
echo