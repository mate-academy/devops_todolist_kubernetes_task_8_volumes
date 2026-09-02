# Validation Instructions

## 1. App is running

```bash
kubectl get pods -n todoapp
```

Ensure the `todoapp` pod is in `Running` status:

```bash
kubectl logs -n todoapp deployment/todoapp
```

Check the app responds:

```bash
kubectl port-forward -n todoapp svc/todoapp-nodeport 8080:8080
curl http://localhost:8080/api/health
```

## 2. ConfigMap data is mounted as files

```bash
kubectl exec -n todoapp deployment/todoapp -- ls /app/configs
kubectl exec -n todoapp deployment/todoapp -- cat /app/configs/PYTHONUNBUFFERED
```

Expected output: `1`

## 3. Secret data is mounted as a file

```bash
kubectl exec -n todoapp deployment/todoapp -- ls /app/secrets
kubectl exec -n todoapp deployment/todoapp -- cat /app/secrets/SECRET_KEY
```

Expected output: Base64-encoded secret value `QGUyKHl4KXYmdGdoM19zPTB5amEtaSFkcGVieHN6XmRnNDd4KS1rJmtxXzN6Zio5ZSoK`
