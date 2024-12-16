#!/bin/bash
kubectl apply -f confgiMap.yml
kubectl apply -f deployment.yml
kubectl apply -f pv.yml
kubectl apply -f pvc.yml