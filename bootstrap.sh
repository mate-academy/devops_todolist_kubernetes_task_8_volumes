#!/bin/bash

cd ./.infrastructure/ && kubectl apply -f namespace.yml

kubectl apply -f clusterIp.yml -n todoapp

kubectl apply -f nodeport.yml -n todoapp

kubectl apply -f secret.yml -n todoapp

kubectl apply -f configMap.yml -n todoapp

kubectl apply -f hpa.yml -n todoapp

kubectl apply -f pv.yml -n todoapp

kubectl apply -f pvc.yml -n todoapp

kubectl apply -f deployment.yml -n todoapp