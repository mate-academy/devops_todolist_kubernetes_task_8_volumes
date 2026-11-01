# INSTRUCTION

Steps to validate the deployed ToDo app, its ConfigMap mount, and its Secret mount.

## 1. Deploy all resources

```
cd .infrastructure
bash ../bootstrap.sh
```

Check that everything is up:

```
kubectl get all -n todoapp
kubectl get pv,pvc -n todoapp
```

Wait until the `todoapp` pod has `STATUS: Running` and `READY: 1/1`.

## 2. Validate the app is running

Get the pod name:

```
kubectl get pods -n todoapp
```

Port-forward to the service (or use the NodePort service directly):

```
kubectl port-forward svc/todoapp-service 8080:80 -n todoapp
```

Open `http://localhost:8080/` in a browser, or:

```
curl http://localhost:8080/api/health
curl http://localhost:8080/api/ready
```

Both endpoints should respond successfully (the same endpoints used by the liveness/readiness probes).

Alternatively, via NodePort:

```
curl http://<NODE_IP>:30007/
```

## 3. Validate ConfigMap data is mounted as files

Exec into the running pod:

```
kubectl exec -it deploy/todoapp -n todoapp -- sh
```

Inside the pod:

```
ls -l /app/configs
cat /app/configs/PYTHONUNBUFFERED
```

Expected:
- `/app/configs` contains a file named `PYTHONUNBUFFERED` (one file per key in `configMap.yml`).
- Its content equals `1`, matching the value set in `.infrastructure/configMap.yml`.
- The mount is read-only — confirm with:

```
touch /app/configs/test
```

This must fail with "Read-only file system".

## 4. Validate Secret data is mounted as a file

Still inside the pod:

```
ls -l /app/secrets
cat /app/secrets/SECRET_KEY
```

Expected:
- `/app/secrets` contains a file named `SECRET_KEY`.
- Its content equals the decoded value from `.infrastructure/secret.yml` (base64-decode it locally to compare):

```
echo "QGUyKHl4KXYmdGdoM19zPTB5amEtaSFkcGVieHN6XmRnNDd4KS1rJmtxXzN6Zio5ZSoK" | base64 -d
```

- The mount is read-only — confirm with:

```
touch /app/secrets/test
```

This must fail with "Read-only file system".

## 5. Validate the PersistentVolume is mounted

Still inside the pod:

```
ls -l /app/data
touch /app/data/testfile
```

`/app/data` should be writable (backed by the `pvc-data` PersistentVolumeClaim bound to the `pv-data` PersistentVolume with `hostPath`).

Exit the pod:

```
exit
```
