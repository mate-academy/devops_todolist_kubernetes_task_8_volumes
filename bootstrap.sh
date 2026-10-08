#!/bin/bash

echo "Starting deployment of ToDo application resources..."

# Apply namespace first
kubectl apply -f .infrastructure/namespace.yml

# Apply configuration resources (ConfigMap and Secret must exist before Deployment)
kubectl apply -f .infrastructure/configMap.yml
kubectl apply -f .infrastructure/secret.yml

# Apply storage resources (PV is cluster-wide, PVC is namespaced)
kubectl apply -f .infrastructure/pv.yml
kubectl apply -f .infrastructure/pvc.yml

# Apply application workload
kubectl apply -f .infrastructure/deployment.yml

echo "All components applied successfully!"
