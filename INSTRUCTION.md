# Validation

After running `bootstrap.sh`, use the steps below to confirm everything is working.

## 1. App is running

Check that the pod is `Running` and `1/1 Ready`:

```bash
kubectl get pods -n todoapp
```

Confirm the app responds (adjust service name/port to match your manifests):

```bash
kubectl get svc -n todoapp
curl http://localhost:todoapp-nodeport/api/health
```

A `200 OK` response confirms the app is up.

## 2. ConfigMap data is mounted as files

Exec into the running pod:

```bash
kubectl exec -n todoapp -it <pod-name> -- sh
```

List the mounted ConfigMap directory:

```bash
ls -la /app/configs
```

Confirm:
- Every key from the ConfigMap appears as a file with the same name.
- File order matches the order keys are defined in `configMap.yml` (Kubernetes preserves key order from the manifest when projecting a ConfigMap as files).

## 3. Secret data is mounted as a file

While still in the pod (or via a new exec session):

```bash
ls -la /app/secrets
```

Confirm the secret key appears as a file

## 4. Clean up the exec session

```bash
exit
```