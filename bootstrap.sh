#!/bin/bash
kind create cluster --config cluster.yml
cd .infrastructure
kubectl apply -f namespace.yml
kubectl config set-context --current --namespace=todoapp
kubectl apply -f clusterIp.yml
kubectl apply -f pv.yml
kubectl apply -f pvc.yml
kubectl apply -f nodeport.yml
kubectl apply -f configMap.yml
kubectl apply -f secret.yml
kubectl apply -f hpa.yml
kubectl apply -f deployment.yml