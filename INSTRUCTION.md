## 1. Check if the pod work

```bash
kubectl get pods -n todoapp

kubectl get deployment -n todoapp
```

## 2. Check ConfigMap
```bash
kubectl exec -n todoapp deploy/todoapp -- ls -la /app/configs

kubectl exec -n todoapp deploy/todoapp -- cat /app/configs/PYTHONUNBUFFERED
```
## 3. Check Secret
```bash
kubectl exec -n todoapp deploy/todoapp -- ls -la /app/secrets

kubectl exec -n todoapp deploy/todoapp -- cat /app/secrets/SECRET_KEY
```

## 4. Check PVC/PV
```bash
kubectl get pv

kubectl get pvc -n todoapp
```