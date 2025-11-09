#!/bin/bash

# Створення namespace mateapp...
kubectl create namespace mateapp --dry-run=client -o yaml | kubectl apply -f -

# Створення PersistentVolume
kubectl apply -f .infrastructure/pv.yml -n mateapp

# Створення PersistentVolumeClaim
kubectl apply -f .infrastructure/pvc.yml -n mateapp

# Застосування ConfigMap та Secret
kubectl apply -f .infrastructure/confgiMap.yml -n mateapp
kubectl apply -f .infrastructure/secret.yml -n mateapp

# Розгортання ToDo застосунку
kubectl apply -f .infrastructure/deployment.yml -n mateapp

# Усі ресурси створено
kubectl get all -n mateapp
