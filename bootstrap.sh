#!/bin/bash
echo 'creating proper namespace' &&

kubectl apply -f .infrastructure/namespace.yml 

echo 'Creating a persistent volume' &&

kubectl apply -f .infrastructure/pv.yml &&

echo 'Applying claim' &&

kubectl apply -f .infrastructure/pvc.yml &&

echo 'Reapply deployment with new settings' &&

kubectl apply -f .infrastructure/deployment.yml 