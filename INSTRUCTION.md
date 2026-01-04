# ===== VALIDATION =====

# 1. Application is running
kubectl get pods -n todoapp

# 2. ConfigMap is mounted as files
kubectl exec -n todoapp -it $(kubectl get pod -n todoapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}') -- ls /app/configs && kubectl exec -n todoapp -it $(kubectl get pod -n todoapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}') -- cat /app/configs/PYTHONUNBUFFERED

# 3. Secret is mounted as a file
kubectl exec -n todoapp -it $(kubectl get pod -n todoapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}') -- ls /app/secrets && kubectl exec -n todoapp -it $(kubectl get pod -n todoapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}') -- cat /app/secrets/SECRET_KEY
