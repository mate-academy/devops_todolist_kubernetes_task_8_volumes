#!/bin/bash

kubectl apply -f ./.infrastructure/pv.yml

kubectl apply -f ./.infrastructure/pvc.yml

kubectl apply -f ./.infrastructure/deployment.yml
