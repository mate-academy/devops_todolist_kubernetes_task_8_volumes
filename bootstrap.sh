#!/bin/bash
set -e 

kubectl apply -f .infrastructure/namespace.yml

kubectl apply -f .infrastructure/app-config.yml
kubectl apply -f .infrastructure/app-secret.yml

kubectl apply -f .infrastructure/pv.yml
kubectl apply -f .infrastructure/pvc.yml

kubectl apply -f .infrastructure/deployment.yml

