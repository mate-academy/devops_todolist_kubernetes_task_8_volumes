# Validation guide

## 1. Deploy resources

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

## 2. Validate app is running

```bash
kubectl get pods -n todoapp
kubectl get svc -n todoapp
kubectl rollout status deployment/todoapp -n todoapp
```

Expected result:
- Deployment `todoapp` is successfully rolled out
- Pod status is `Running`

## 3. Validate ConfigMap is mounted as files in `/app/configs`

```bash
POD_NAME=$(kubectl get pods -n todoapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}')
kubectl exec -n todoapp "$POD_NAME" -- ls -1 /app/configs
kubectl exec -n todoapp "$POD_NAME" -- cat /app/configs/PYTHONUNBUFFERED
```

Expected result:
- Key from ConfigMap exists as a file in `/app/configs`
- File content is `1`
- File list order (`ls -1`) matches ConfigMap keys order for this task (single key file: `PYTHONUNBUFFERED`)

## 4. Validate Secret is mounted as files in `/app/secrets`

```bash
kubectl exec -n todoapp "$POD_NAME" -- ls -1 /app/secrets
kubectl exec -n todoapp "$POD_NAME" -- sh -c 'test -s /app/secrets/SECRET_KEY && echo "SECRET_KEY file exists and is not empty"'
```

Expected result:
- `SECRET_KEY` exists as a file in `/app/secrets`
- Secret file is not empty

## 5. Validate persistent volume mount `/app/data`

```bash
kubectl exec -n todoapp "$POD_NAME" -- sh -c 'echo volume-ok > /app/data/check.txt && cat /app/data/check.txt'
```

Expected result:
- Value `volume-ok` is written and read from `/app/data`
