# TodoApp Volumes Instructions

## 1. Deploy to cluster

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

Verify resources are created:

```bash
kubectl get pv
kubectl get pvc -n todoapp
kubectl get pods -n todoapp
```

---

## 2. Validate app is running

Check that pods are in `Running` state:

```bash
kubectl get pods -n todoapp
```

Check the health endpoint via port-forward:

```bash
kubectl port-forward service/todoapp-clusterip 8080:80 -n todoapp
curl http://localhost:8080/api/health
```

---

## 3. Validate ConfigMap is mounted as files

Exec into a running pod:

```bash
kubectl exec -it <pod-name> -n todoapp -- ls /app/configs
```

You should see `PYTHONUNBUFFERED` listed as a file. Check its content:

```bash
kubectl exec -it <pod-name> -n todoapp -- cat /app/configs/PYTHONUNBUFFERED
```

Expected output: `1`

---

## 4. Validate Secret is mounted as files

```bash
kubectl exec -it <pod-name> -n todoapp -- ls /app/secrets
```

You should see `SECRET_KEY` listed as a file. Check it exists:

```bash
kubectl exec -it <pod-name> -n todoapp -- cat /app/secrets/SECRET_KEY
```

You should see the secret value printed.
