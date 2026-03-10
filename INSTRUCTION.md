# Validation

Prerequisites: `kubectl` configured, resources deployed with `./bootstrap.sh`.

**1. App running**

```bash
kubectl get pods -n todoapp
kubectl get deployment todoapp -n todoapp
# Optional: kubectl port-forward -n todoapp svc/todoapp-nodeport 8080:80 && curl http://localhost:8080/api/health
```

**2. ConfigMap mounted at `/app/configs` (read-only, correct order)**

```bash
POD=$(kubectl get pods -n todoapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}')
kubectl exec -n todoapp "$POD" -- ls -la /app/configs
kubectl exec -n todoapp "$POD" -- cat /app/configs/PYTHONUNBUFFERED
# Expect: 1. Read-only: touch /app/configs/x should fail
```

**3. Secret mounted at `/app/secrets` (read-only, as file)**

```bash
kubectl exec -n todoapp "$POD" -- ls -la /app/secrets
kubectl exec -n todoapp "$POD" -- test -r /app/secrets/SECRET_KEY && echo "OK"
# Read-only: touch /app/secrets/x should fail
```
