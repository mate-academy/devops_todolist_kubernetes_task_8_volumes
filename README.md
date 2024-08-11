# Apply PersistentVolume

kubectl apply -f pv.yml

# Apply PersistentVolumeClaim

kubectl apply -f pvc.yml

# Apply Deployment

kubectl apply -f deployment.yml

bash bootstrap.sh

# Verify applied changes

kubectl get deployments -n todoapp

kubectl get pv -n todoapp

kubectl get pvc -n todoapp
