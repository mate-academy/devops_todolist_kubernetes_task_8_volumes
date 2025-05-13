#!/bin/bash

kubectl apply -f pv.yml

kubectl apply -f pvc.yml

kubectl apply -f configmap.yml

kubectl apply -f secrets.yml

kubectl apply -f deployment.yml

kubectl rollout status deployment/todoapp