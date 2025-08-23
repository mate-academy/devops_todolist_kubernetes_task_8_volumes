# ToDo Application Validation Instructions

## Deployment
```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

## Validation

### 1. App is Running
```bash
kubectl get pods -l app=todo-app
```
Pod should be in `Running` status.

### 2. ConfigMap Mounted as Files
```bash
POD_NAME=$(kubectl get pods -l app=todo-app -o jsonpath='{.items[0].metadata.name}')
kubectl exec -it $POD_NAME -- ls -la /app/configs/
```
Should list ConfigMap keys as files in correct order.

### 3. Secret Mounted as Files
```bash
kubectl exec -it $POD_NAME -- ls -la /app/secrets/
```
Should list Secret keys as files.

## Quick Check
```bash
kubectl get all,pv,pvc
kubectl exec -it $POD_NAME -- touch /app/data/test.txt
```