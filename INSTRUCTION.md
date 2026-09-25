kubectl get pods -n todoapp
kubectl exec -n todoapp <pod-name> -- ls -la /app/configs
kubectl exec -n todoapp <pod-name> -- cat /app/configs/PYTHONUNBUFFERED
kubectl exec -n todoapp <pod-name> -- ls -la /app/secrets
kubectl exec -n todoapp <pod-name> -- cat /app/secrets/SECRET_KEY