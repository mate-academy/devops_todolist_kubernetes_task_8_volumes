#!/bin/bash
kind create cluster --config cluster.yml &&

kubectl apply -f .infrastructure/namespace.yml &&

kubectl apply -f .infrastructure/nodeport.yml -n todoapp &&

kubectl apply -f .infrastructure/pv.yml &&
kubectl apply -f .infrastructure/pvc.yml -n todoapp &&

kubectl apply -f .infrastructure/configMap.yml -n todoapp &&
kubectl apply -f .infrastructure/secret.yml -n todoapp &&

kubectl apply -f .infrastructure/deployment.yml -n todoapp &&
kubectl apply -f .infrastructure/hpa.yml -n todoapp
