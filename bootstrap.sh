#!/bin/bash


echo "Starting Kubernetes bootstrap process..."

# 1. Create Namespace
echo "Applying Namespace..."
kubectl apply -f ./.infrastructure/namespace.yml

# 2. Apply ConfigMap
echo "Applying ConfigMap..."
kubectl apply -f ./.infrastructure/configMap.yml

# 3. Apply Secret
echo "Applying Secret..."
kubectl apply -f ./.infrastructure/secret.yml

# 4. Apply PersistentVolume and PersistentVolumeClaim
echo "Applying PersistentVolume and PersistentVolumeClaim..."
kubectl apply -f ./.infrastructure/pv.yml
kubectl apply -f ./.infrastructure/pvc.yml

# 5. Apply Deployment
echo "Applying Deployment..."
kubectl apply -f ./.infrastructure/deployment.yml

# 6. Apply Services
echo "Applying ClusterIP and NodePort services..."
kubectl apply -f ./.infrastructure/clusterip.yml
kubectl apply -f ./.infrastructure/nodeport.yml

# 7. Apply HPA
echo "Applying Horizontal Pod Autoscaler..."
kubectl apply -f ./.infrastructure/hpa.yml

# End
echo "Kubernetes bootstrap process completed successfully!"
