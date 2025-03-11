#!/bin/bash
kubectl apply -f .infrastructure/pv.yml
kubectl apply -f .infrastructure/pvc.yml
kubectl apply -f .infrastructure/configmap.yml
kubectl apply -f .infrastructure/secret.yml
kubectl apply -f .infrastructure/cluster.yml
kubectl apply -f .infrastructure/clustrip.yml
kubectl apply -f .infrastructure/hpa.yml
kubectl apply -f .infrastructure/namespace.yml
kubectl apply -f .infrastructure/nodeport.yml
kubectl apply -f .infrastructure/deployment.yml