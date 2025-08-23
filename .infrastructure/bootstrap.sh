# Deploy ToDo Kubernetes resources
echo "Deploying ToDo application resources..."

echo "Creating PersistentVolume..."
kubectl apply -f pv.yml

echo "Creating PersistentVolumeClaim..."
kubectl apply -f pvc.yml

echo "Waiting for PVC to be bound..."
kubectl wait --for=condition=Bound pvc/todo-pvc --timeout=60s

echo "Creating Deployment..."
kubectl apply -f deployment.yml

echo "Waiting for deployment to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/todo-app

echo "Deployment completed successfully!"
echo "Use 'kubectl get pods' to check the status of your pods"
echo "Use 'kubectl get pv,pvc' to check persistent volumes"