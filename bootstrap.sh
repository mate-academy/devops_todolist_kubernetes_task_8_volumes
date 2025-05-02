#!/bin/bash
kind create cluster --config cluster.yml \
&& cd .infrastructure \
&& kubectl apply -f namespace.yml \
&& kubectl apply -f pv.yml -n todoapp \
&& kubectl apply -f pvc.yml -n todoapp \
&& kubectl apply -f clusterIp.yml -n todoapp \
&& kubectl apply -f nodePort.yml -n todoapp \
&& kubectl apply -f secret.yml -n todoapp \
&& kubectl apply -f confgiMap.yml -n todoapp \
&& kubectl apply -f deployment.yml -n todoapp
