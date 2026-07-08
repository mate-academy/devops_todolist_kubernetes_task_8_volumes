# Validation Instructions

## 1. Verify the application is running

Check that the Pod is in the `Running` state:

```bash
kubectl get pods -n todoapp
```

Verify the container is ready:

```bash
kubectl describe pod <pod-name> -n todoapp
```

(Optional) Check the application logs:

```bash
kubectl logs <pod-name> -n todoapp
```

---

## 2. Verify ConfigMap is mounted as files

List the files mounted from the ConfigMap:

```bash
kubectl exec -it <pod-name> -n todoapp -- ls -l /app/configs
```

Verify the files are present in the expected order:

```bash
kubectl exec -it <pod-name> -n todoapp -- find /app/configs -maxdepth 1 -type f | sort
```

Inspect the contents of a mounted file:

```bash
kubectl exec -it <pod-name> -n todoapp -- cat /app/configs/PYTHONUNBUFFERED
```

---

## 3. Verify Secret is mounted as files

List the mounted secret files:

```bash
kubectl exec -it <pod-name> -n todoapp -- ls -l /app/secrets
```

Verify the secret file contents:

```bash
kubectl exec -it <pod-name> -n todoapp -- cat /app/secrets/SECRET_KEY
```

