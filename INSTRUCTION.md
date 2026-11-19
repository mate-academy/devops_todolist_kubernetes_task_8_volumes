# Django ToDo — Kubernetes Persistent Storage

## Purpose

This task deploys the Django ToDo application with a `hostPath` PersistentVolume (PV), a PersistentVolumeClaim (PVC), and read-only file mounts for an existing ConfigMap and Secret.

The Kubernetes resources use these names:

| Resource | Name / path |
|---|---|
| Namespace | `todoapp` |
| PersistentVolume | `pv-volume` |
| PersistentVolumeClaim | `pvc-volume` |
| ConfigMap | `app-config` |
| Secret | `app-secret` |
| Deployment | `todoapp` |
| Data directory in the container | `/app/data` |
| ConfigMap files in the container | `/app/configs` |
| Secret files in the container | `/app/secrets` |
| Docker image | `ikulyk404/todoapp:3.0.0` |

## 1. Prerequisites

Docker Desktop or another Kubernetes cluster must be running. `kubectl` must be connected to the intended cluster. Run these commands from the repository root unless otherwise specified.

```bash
kubectl config current-context
kubectl get nodes
```

Keep `pv.yml`, `pvc.yml`, and `deployment.yml` either in `.infrastructure/` or in the repository root. Place `bootstrap.sh` and `INSTRUCTION.md` in the repository root.

**Important:** The PV uses `storageClassName: standard`, `persistentVolumeReclaimPolicy: Delete`, `accessModes: [ReadWriteMany]`, `capacity: 1Gi`, and `hostPath`. The PVC uses the same storage class, requests `1Gi`, and binds to `volumeName: pv-volume` in namespace `todoapp`.

## 2. Required Deployment configuration

Before deployment, verify that `deployment.yml` has all three volume mounts within the `todoapp` container:

```yaml
volumeMounts:
  - name: data
    mountPath: /app/data
  - name: app-secret
    mountPath: /app/secrets
    readOnly: true
  - name: app-config
    mountPath: /app/configs
    readOnly: true
```

Declare the volumes under `spec.template.spec`, at the same indentation level as `containers`:

```yaml
volumes:
  - name: data
    persistentVolumeClaim:
      claimName: pvc-volume
  - name: app-secret
    secret:
      secretName: app-secret
  - name: app-config
    configMap:
      name: app-config
```

The names must match exactly. The `volumeMounts` entries alone are not enough to mount volumes.

## 3. Bootstrap all resources

The script creates namespace `todoapp` if needed, applies the PV and PVC, ensures `app-config` and `app-secret` exist, and applies the Deployment. If the ConfigMap or Secret does not exist, the script creates it. When the Secret is absent, it generates a fresh random Django `SECRET_KEY` locally without placing the key in the repository. **If `app-secret` already exists, the script preserves its current value; ensure it is a valid, non-placeholder key before deploying.**

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

The script also restarts the Deployment so environment variables are refreshed in its Pods.

To replace an existing placeholder `SECRET_KEY` before running the bootstrap script, use:

```bash
kubectl create secret generic app-secret \
  --namespace todoapp \
  --from-literal="SECRET_KEY=$(python3 -c 'import secrets; print(secrets.token_urlsafe(48))')" \
  --dry-run=client -o yaml | kubectl apply -f -
```

This command replaces the content of the Secret with a new key. Do not commit a real key (including Base64-encoded values) into Git.

## 4. Verify the application is running

Check the PV/PVC binding, Deployment status, and Pods:

```bash
kubectl get pv pv-volume
kubectl get pvc pvc-volume -n todoapp
kubectl rollout status deployment/todoapp -n todoapp
kubectl get pods -n todoapp -l app=todoapp
```

Expected: PV and PVC have status `Bound`; the new Pods show `Running` and eventually `READY 1/1`.

Check logs when troubleshooting:

```bash
kubectl logs -n todoapp deployment/todoapp --tail=50
kubectl describe pods -n todoapp -l app=todoapp
```

To reach the application, open a separate terminal and run:

```bash
kubectl port-forward -n todoapp deployment/todoapp 8086:8080
```

Then open <http://localhost:8086/>. If the image exposes the expected Django health endpoint, test:

```bash
curl -i http://localhost:8086/api/health
```

## 5. Verify ConfigMap is mounted as a file

The ConfigMap `app-config` must be mounted read-only into `/app/configs`. Confirm its key is represented as a file and inspect the non-secret value:

```bash
kubectl exec -n todoapp deployment/todoapp -- ls -l /app/configs
kubectl exec -n todoapp deployment/todoapp -- cat /app/configs/PYTHONUNBUFFERED
```

Expected value: `1` (assuming that is the current value of `PYTHONUNBUFFERED`).

## 6. Verify Secret is mounted as a file

The Secret `app-secret` must be mounted read-only into `/app/secrets`. Check that the Secret file exists and is nonempty **without displaying its value**:

```bash
kubectl exec -n todoapp deployment/todoapp -- sh -c 'test -s /app/secrets/SECRET_KEY && echo "SECRET_KEY file is mounted"'
```

Expected output: `SECRET_KEY file is mounted`.

Verify the mounts are configured as read-only in the Kubernetes manifest:

```bash
kubectl get deployment todoapp -n todoapp -o yaml
```

Look for `readOnly: true` under the `app-config` and `app-secret` entries in `volumeMounts`.

## 7. Verify the PersistentVolume mount

Check the PVC and the `/app/data` directory:

```bash
kubectl get pvc pvc-volume -n todoapp
kubectl exec -n todoapp deployment/todoapp -- ls -ld /app/data
```

A test file can demonstrate persistence when the replacement Pod mounts the same underlying node directory:

```bash
kubectl exec -n todoapp deployment/todoapp -- sh -c 'echo persistent-storage-test > /app/data/persistence-check.txt'
kubectl rollout restart deployment/todoapp -n todoapp
kubectl rollout status deployment/todoapp -n todoapp
kubectl exec -n todoapp deployment/todoapp -- cat /app/data/persistence-check.txt
```

Expected output is `persistent-storage-test` **when the restarted Pod accesses the same hostPath storage**. If the test fails, first inspect scheduling and the node hosting the Pod.

**Limitations:** `hostPath` stores files on a Kubernetes node; it is not shared storage across separate kind nodes. Declaring `ReadWriteMany` does not make node-local directories shared. Also, mounting `/app/data` does not automatically persist Django's SQLite database if the database file is stored elsewhere, such as `/app/db.sqlite3`.

## 8. Submit the assignment

Before creating the Pull Request, check that no real secret values are committed:

```bash
git status
git diff --cached
```

Commit `pv.yml`, `pvc.yml`, the updated `deployment.yml`, `bootstrap.sh`, and `INSTRUCTION.md`. Push the working branch and create a Pull Request according to the Mate Academy instructions.
