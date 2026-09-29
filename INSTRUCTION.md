# Task 8: PersistentVolume, PVC, and volume mounts

## Deploy

From the repository root:

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

Or apply manifests manually in the same order as in `bootstrap.sh`.

Wait for the Deployment:

```bash
kubectl wait --for=condition=Available deployment/todoapp -n todoapp --timeout=180s
kubectl get pv,pvc,pods -n todoapp
```

PVC `todoapp-pvc` should be **Bound** to PV `todoapp-pv`.

## Validate the app is running

```bash
kubectl get pods -n todoapp -l app=todoapp
kubectl logs -n todoapp -l app=todoapp --tail=30
```

Health check (ClusterIP):

```bash
kubectl port-forward -n todoapp service/todoapp-service 8080:80
```

In another terminal:

```bash
curl -sS http://127.0.0.1:8080/api/health
curl -sS http://127.0.0.1:8080/api/ready
```

## Validate PersistentVolume / PVC

```bash
kubectl get pv todoapp-pv
kubectl get pvc todoapp-pvc -n todoapp
kubectl describe pvc todoapp-pvc -n todoapp
```

Inside a pod, data directory should be writable (SQLite DB and other files):

```bash
POD=$(kubectl get pods -n todoapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}')
kubectl exec -n todoapp "$POD" -- ls -la /app/data
kubectl exec -n todoapp "$POD" -- touch /app/data/.volume-test && kubectl exec -n todoapp "$POD" -- rm /app/data/.volume-test
```

## Validate ConfigMap mount (read-only files)

ConfigMap `app-config` is mounted under **`/app/configs`**. Each key becomes a file named after the key.

```bash
kubectl exec -n todoapp "$POD" -- ls -la /app/configs
kubectl exec -n todoapp "$POD" -- cat /app/configs/PYTHONUNBUFFERED
```

Expected: file `PYTHONUNBUFFERED` with content `1`.

Read-only check (should fail):

```bash
kubectl exec -n todoapp "$POD" -- sh -c 'echo test >> /app/configs/PYTHONUNBUFFERED' && echo "unexpected: write succeeded" || echo "OK: read-only mount"
```

## Validate Secret mount (read-only files)

Secret `app-secret` is mounted under **`/app/secrets`**.

```bash
kubectl exec -n todoapp "$POD" -- ls -la /app/secrets
kubectl exec -n todoapp "$POD" -- cat /app/secrets/SECRET_KEY
```

Expected: file `SECRET_KEY` with the Django secret (same value as in the Secret resource, decoded).

Read-only check:

```bash
kubectl exec -n todoapp "$POD" -- sh -c 'echo x >> /app/secrets/SECRET_KEY' && echo "unexpected: write succeeded" || echo "OK: read-only mount"
```

## Notes

- PV uses **hostPath** on the node at `/app/data` with **ReadWriteMany** — typical for local single-node clusters (Minikube, Docker Desktop). On multi-node clusters, RWX + hostPath may not schedule as expected.
- Env vars (`PYTHONUNBUFFERED`, `SECRET_KEY`) still come from ConfigMap/Secret via `env`; file mounts under `/app/configs` and `/app/secrets` are additional volume mounts required by the task.

## Clean up (optional)

```bash
kubectl delete -f .infrastructure/nodeport.yml
kubectl delete -f .infrastructure/hpa.yml
kubectl delete -f .infrastructure/clusterIp.yml
kubectl delete -f .infrastructure/deployment.yml
kubectl delete -f .infrastructure/pvc.yml
kubectl delete -f .infrastructure/pv.yml
kubectl delete -f .infrastructure/secret.yml
kubectl delete -f .infrastructure/configMap.yml
kubectl delete -f .infrastructure/namespace.yml
```
