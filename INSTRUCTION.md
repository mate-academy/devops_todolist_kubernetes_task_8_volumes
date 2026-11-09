# ToDo app: Volumes

## What was added

- `.infrastructure/pv.yml`: PersistentVolume `pv-data`, class `standard`, reclaim policy `Delete`, access mode `ReadWriteMany`, capacity `1Gi`, `hostPath` `/data/` on the node (in `cluster.yml` the host `/tmp` is mounted into every node as `/data`).
- `.infrastructure/pvc.yml`: PersistentVolumeClaim `pvc-data` in the `todoapp` namespace that claims `pv-data` by `volumeName`.
- `.infrastructure/deployment.yml`:
  - `pvc-data` is mounted to `/app/data`;
  - ConfigMap `app-config` is mounted as files to `/app/configs` (read-only);
  - Secret `app-secret` is mounted as files to `/app/secrets` (read-only).
- `bootstrap.sh`: applies all the resources in the right order.

## 1. Deploy

```bash
./bootstrap.sh
```

If you use the kind cluster from this repository, create it first:

```bash
kind create cluster --config cluster.yml
```

## 2. Validate that PV and PVC are bound

```bash
kubectl get pv pv-data
kubectl get pvc pvc-data -n todoapp
```

Both must have the status `Bound`. See which pods use the claim:

```bash
kubectl describe pvc pvc-data -n todoapp
```

The `Used By` field lists the ToDo app pods.

## 3. Validate that the app is running

```bash
kubectl get pods -n todoapp
kubectl rollout status deployment/todoapp -n todoapp
```

All pods must be `1/1 Running`. Check the health endpoint:

```bash
kubectl port-forward service/todoapp-service 8080:80 -n todoapp
```

In another terminal:

```bash
curl http://localhost:8080/api/health
```

Expected: `Health OK`. The app is available at http://localhost:8080.

## 4. Validate that ConfigMap data is mounted as files

Every key of the ConfigMap becomes a file in `/app/configs`, the file name is the key, the file content is the value:

```bash
kubectl exec -n todoapp deploy/todoapp -- ls -l /app/configs
kubectl exec -n todoapp deploy/todoapp -- cat /app/configs/PYTHONUNBUFFERED
```

Expected: a file `PYTHONUNBUFFERED` with the content `1`, the same as in `.infrastructure/configMap.yml`.

## 5. Validate that Secret data is mounted as a file

```bash
kubectl exec -n todoapp deploy/todoapp -- ls -l /app/secrets
kubectl exec -n todoapp deploy/todoapp -- cat /app/secrets/SECRET_KEY
```

Expected: a file `SECRET_KEY`. Its content is the decoded value from `.infrastructure/secret.yml`; compare it with:

```bash
kubectl get secret app-secret -n todoapp -o jsonpath='{.data.SECRET_KEY}' | base64 -d
```

## 6. Validate that the mounts are read-only

```bash
kubectl exec -n todoapp deploy/todoapp -- touch /app/configs/test
kubectl exec -n todoapp deploy/todoapp -- touch /app/secrets/test
```

Both commands must fail with `Read-only file system`.

## 7. Validate the data volume

```bash
kubectl exec -n todoapp deploy/todoapp -- sh -c 'echo hello > /app/data/test.txt && ls -l /app/data'
```

The file is stored on the PersistentVolume, so it stays after the pods are recreated:

```bash
kubectl rollout restart deployment/todoapp -n todoapp
kubectl rollout status deployment/todoapp -n todoapp
kubectl exec -n todoapp deploy/todoapp -- cat /app/data/test.txt
```

Expected: `hello`.
