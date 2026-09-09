#!/bin/bash
kubectl apply -f pv_tr.yml
kubectl apply -f pvc-tr.yml
kubectl apply -f deployment.yml