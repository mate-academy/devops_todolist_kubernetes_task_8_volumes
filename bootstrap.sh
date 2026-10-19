#!/bin/bash

kind create cluster --config cluster.yml

kubectl apply -f .infrastructure/namespace.yml

kubectl apply -f .infrastructure/clusterIp.yml
kubectl apply -f .infrastructure/nodePort.yml

kubectl apply -f .infrastructure/pv.yml
kubectl apply -f .infrastructure/pvc.yml
kubectl apply -f .infrastructure/configmap.yml
kubectl apply -f .infrastructure/secrets.yml
kubectl apply -f .infrastructure/deployment.yml

kubectl apply -f .infrastructure/hpa.yml