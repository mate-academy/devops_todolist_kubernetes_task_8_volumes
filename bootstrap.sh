#!/bin/bash

# Apply namespace
kubectl apply -f .infrastructure/namespace.yml

# Apply PersistentVolume
kubectl apply -f .infrastructure/pv.yml

# Apply PersistentVolumeClaim
kubectl apply -f .infrastructure/pvc.yml

# Apply ConfigMap
kubectl apply -f .infrastructure/confgiMap.yml

# Apply Secret
kubectl apply -f .infrastructure/secret.yml

# Apply Deployment
kubectl apply -f .infrastructure/deployment.yml

# Apply Services
kubectl apply -f .infrastructure/clusterIp.yml
kubectl apply -f .infrastructure/nodeport.yml

# Apply HorizontalPodAutoscaler
kubectl apply -f .infrastructure/hpa.yml

echo "All resources have been deployed successfully!"

