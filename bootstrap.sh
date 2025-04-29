#!/bin/bash
cd .infrastructure
kubectl apply -f pv.yml
kubectl apply -f pvc.yml
kubectl apply -f confgiMap.yml
kubectl apply -f secret.yml
kubectl apply -f deployment.yml



