# Validation Instructions
## 1. App is running
```
kubectl get pods
kubectl get svc
```

## 2. ConfigMap mounted as files
```
kubectl exec -it <pod-name> -- ls -la /app/config/
```

## 3. Secrets mounted as files
```
kubectl exec -it <pod-name> -- ls -la /app/secret/
```