## Validation

### 0. Run app
```bash
sh bootstrap.sh
```

### 1. App is running
```bash
kubectl get pods -n todoapp
kubectl get pvc -n todoapp          # STATUS should be Bound
kubectl port-forward -n todoapp deployment/todoapp 8080:8080
curl http://localhost:8080/api/health
```

### 2. ConfigMap data is mounted as files
```bash
kubectl get pod -n todoapp   # copy one pod name
kubectl exec -n todoapp <pod-name> -- ls -l /app/configs
kubectl exec -n todoapp <pod-name> -- cat /app/configs/PYTHONUNBUFFERED   # prints 1
```

### 3. Secret data is mounted as a file
```bash
kubectl exec -n todoapp <pod-name> -- ls -l /app/secrets
kubectl exec -n todoapp <pod-name> -- cat /app/secrets/SECRET_KEY
```

### 4. Database is on the PersistentVolume
```bash
kubectl exec -n todoapp <pod-name> -- ls -l /app/data       # db.sqlite3 is present
kubectl delete pod -n todoapp <pod-name>                    # data survives the restart
```