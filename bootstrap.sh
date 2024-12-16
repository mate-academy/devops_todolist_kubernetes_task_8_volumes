#!/bin/bash
kubectl apply -f configMap.yml
kubectl apply -f deployment.yml
kubectl apply -f pv.yml
kubectl apply -f pvc.yml