## Validation steps

### 1 App is running

```
kubectl get pods -n todoapp
kubectl port-forward svc/todoapp-service 8080:80 -n todoapp
```

Open in browser
http://localhost:8080

### 2 ConfigMap data is mounted as files in the right order

get pod name using

```
kubectl get pods -n todoapp
```

use pod_name in commands below

```
kubectl exec -n todoapp "POD_NAME" -- ls -la /app/configs
kubectl exec -n todoapp "POD_NAME" -- cat /app/configs/PYTHONUNBUFFERED
```

Expected: file `PYTHONUNBUFFERED` exists and contains `1`.

### 3 Secret data is mounted as a file

```
kubectl exec -n todoapp "POD_NAME" -- ls -la /app/secrets
kubectl exec -n todoapp "POD_NAME" -- cat /app/secrets/SECRET_KEY
```

Expected: file `SECRET_KEY` exists (content is the decoded secret).
