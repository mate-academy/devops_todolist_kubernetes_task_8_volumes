#!/bin/bash

# Створення PersistentVolume
kubectl apply -f pv.yml

# Створення PersistentVolumeClaim
kubectl apply -f pvc.yml

# Створення ConfigMap (якщо ще немає)
kubectl create configmap my-config --from-literal=setting1=value1 --from-literal=setting2=value2

# Створення Secret (якщо ще немає)
kubectl create secret generic my-secret --from-literal=password=secretpassword --from-literal=username=admin

# Створення Deployment
kubectl apply -f deployment.yml