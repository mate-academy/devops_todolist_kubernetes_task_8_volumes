./bootstrap.sh

kubectl get pods
kubectl get pods -n todoapp
kubectl describe pods

POD_NAME=$(kubectl get pods -n todoapp -l app=todoapp -o jsonpath="{.items[0].metadata.name}")
kubectl exec POD_NAME -n todoapp -- ls /app/configs
kubectl exec POD_NAME -n todoapp -- ls /app/secrets
