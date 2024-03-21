#!/bin/bash

# Apply the Namespace
kubectl apply -f .infrastructure/namespace.yml

# Apply the PersistentVolume
kubectl apply -f .infrastructure/pv.yml

# Apply the PersistentVolumeClaim
kubectl apply -f .infrastructure/pvc.yml

# Apply the ConfigMap
kubectl apply -f .infrastructure/configMap.yml

# Apply the Secret
kubectl apply -f .infrastructure/secret.yml

# Apply ClusterIp, Nodeport, and Hpa services
kubectl apply -f .infrastructure/clusterIp.yml
kubectl apply -f .infrastructure/nodeport.yml
kubectl apply -f .infrastructure/hpa.yml

# Apply the Deployment
kubectl apply -f .infrastructure/deployment.yml
