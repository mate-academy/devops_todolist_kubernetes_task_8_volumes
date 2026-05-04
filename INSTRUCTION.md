# Validation Instructions
## 1. Check if app is running
```bash
kubectl get pods -n todoapp
kubectl get svc -n todoapp
2. Verify ConfigMap is mounted
kubectl exec -it <pod-name> -n todoapp -- ls -la /app/configs
kubectl exec -it <pod-name> -n todoapp -- cat /app/configs/PYTHONUNBUFFERED
3. Verify Secret is mounted
kubectl exec -it <pod-name> -n todoapp -- ls -la /app/secrets
kubectl exec -it <pod-name> -n todoapp -- cat /app/secrets/SECRET_KEY
4. Verify PV is mounted
kubectl exec -it <pod-name>