#!/bin/bash

cd .infrastructure || exit 1

echo "Apply namespace"
kubectl apply -f namespace.yml

echo "Apply secrets"
kubectl apply -f secret.yml -n todoapp

echo "Apply configMap"
kubectl apply -f configMap.yml -n todoapp

echo "Apply PersistentVolume"
kubectl apply -f pv.yml

echo "Apply PersistentVolumeClaim"
kubectl apply -f pvc.yml -n todoapp

echo "Waiting for PVC to be Bound..."
until kubectl get pvc -n todoapp | grep -q Bound; do
  sleep 2
done
echo "PVC is Bound"

echo "Apply Deployment"
kubectl apply -f deployment.yml -n todoapp

echo "Waiting for Pod to be Running..."
until kubectl get pods -n todoapp | grep -q Running; do
  sleep 2
done
echo "Pod is Running"

echo "Apply Service (NodePort)"
kubectl apply -f nodeport.yml -n todoapp

echo "Apply HPA"
kubectl apply -f hpa.yml -n todoapp

echo "Done"