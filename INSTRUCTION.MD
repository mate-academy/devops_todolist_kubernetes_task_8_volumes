# Instructions

## Deploy

./bootstrap.sh

## Validate

### 1. App is running
kubectl get pods -n todoapp
# Expect STATUS: Running, READY: 1/1

### 2. ConfigMap mounted as files
kubectl exec -it -n todoapp deploy/todoapp -- ls -la /app/configs
kubectl exec -it -n todoapp deploy/todoapp -- cat /app/configs/PYTHONUNBUFFERED

### 3. Secret mounted as a file
kubectl exec -it -n todoapp deploy/todoapp -- ls -la /app/secrets
kubectl exec -it -n todoapp deploy/todoapp -- cat /app/secrets/SECRET_KEY