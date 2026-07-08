#!/bin/bash

set -e

kubectl create namespace todoapp --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -f configmap.yml -n todoapp
kubectl apply -f secret.yml -n todoapp

kubectl apply -f pv.yml -n todoapp
kubectl apply -f pvc.yml -n todoapp

kubectl apply -f deployment.yml -n todoapp

kubectl rollout status deployment/todoapp -n todoapp
