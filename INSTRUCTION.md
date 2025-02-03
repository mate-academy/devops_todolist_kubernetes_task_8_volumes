# Instructions on how to apply PersistentVolume and PersistentVolumeClaim to the cluster.

# How to deploy the PersistentVolume to your cluster:
kubectl apply -f pv.yml -n todoapp

# How to deploy the PersistentVolumeClaim to your cluster:
kubectl apply -f pvc.yml -n todoapp

# After that, apply the ConfigMap and Secret:
kubectl apply -f configmap.yml -n todoapp
kubectl apply -f secrets.yml -n todoapp

# Finally, deploy the application:
kubectl apply -f deployment.yml -n todoapp

# How to verify that the ConfigMap and Secret are mounted as files in the right order:
kubectl get pods -n todoapp  # Get the pod name
kubectl exec -it <pod_name> -n todoapp -- /bin/sh
ls -l /app/configs
ls -l /app/secrets
