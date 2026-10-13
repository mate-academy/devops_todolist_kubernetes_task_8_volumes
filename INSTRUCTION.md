# Validation

## Deploy
bash bootstrap.sh

## App is running
kubectl get pods -n todoapp
kubectl get pvc -n todoapp

Pods must be in `Running` status, PVC must be `Bound`.

## ConfigMap data is mounted as files
kubectl exec -n todoapp deploy/todoapp -- ls /app/configs
kubectl exec -n todoapp deploy/todoapp -- cat /app/configs/PYTHONUNBUFFERED

## Secret data is mounted as a file
kubectl exec -n todoapp deploy/todoapp -- ls /app/secrets
kubectl exec -n todoapp deploy/todoapp -- cat /app/secrets/SECRET_KEY