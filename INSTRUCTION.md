# Kubernetes Volumes — Deployment and Validation Guide

This guide describes how to deploy and validate the ToDo application with:

- a `PersistentVolume` (PV);
- a `PersistentVolumeClaim` (PVC);
- persistent data mounted at `/app/data`;
- ConfigMap data mounted as files at `/app/configs`;
- Secret data mounted as files at `/app/secrets`.

The examples below use the `todoapp` namespace.

---

## 1. Expected manifest files

The `.infrastructure` directory should contain at least:

```text
.infrastructure/
├── namespace.yml
├── pv.yml
├── pvc.yml
├── configMap.yml
├── secret.yml
├── deployment.yml
├── clusterIp.yml
├── nodeport.yml
└── hpa.yml
```

> If your ConfigMap file is currently named `confgiMap.yml`, rename it to `configMap.yml` for consistency:
>
> ```bash
> mv .infrastructure/confgiMap.yml .infrastructure/configMap.yml
> ```

---

## 2. PersistentVolume

The PV should satisfy these requirements:

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: todo-pv
spec:
  storageClassName: standard
  persistentVolumeReclaimPolicy: Delete
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteMany
  hostPath:
    path: /data
```

Important:

- `PersistentVolume` is cluster-scoped, so it should not contain a `namespace`.
- Capacity is `1Gi`.
- Access mode is `ReadWriteMany`.
- Storage class is `standard`.
- Reclaim policy is `Delete`.
- The volume uses `hostPath`.

---

## 3. PersistentVolumeClaim

The PVC should explicitly claim `todo-pv`:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: todo-pvc
  namespace: todoapp
spec:
  volumeName: todo-pv
  storageClassName: standard
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Gi
```

Do not add `persistentVolumeReclaimPolicy` to a PVC. That field belongs to the PV.

---

## 4. Deployment volume configuration

The application Deployment should:

1. mount the PVC at `/app/data`;
2. mount the existing ConfigMap as files at `/app/configs`;
3. mount the existing Secret as files at `/app/secrets`;
4. make ConfigMap and Secret mounts read-only.

Add these mounts to the application container:

```yaml
volumeMounts:
  - name: app-data
    mountPath: /app/data

  - name: app-config
    mountPath: /app/configs
    readOnly: true

  - name: app-secrets
    mountPath: /app/secrets
    readOnly: true
```

Add these volumes to the Pod template:

```yaml
volumes:
  - name: app-data
    persistentVolumeClaim:
      claimName: todo-pvc

  - name: app-config
    configMap:
      name: app-config

  - name: app-secrets
    secret:
      secretName: app-secret
```

The important relationship is:

```text
todo-pv
   ↑
todo-pvc
   ↑
Deployment
   ↓
/app/data
```

The ConfigMap and Secret are mounted as files:

```text
app-config
   ↓
/app/configs/PYTHONUNBUFFERED

app-secret
   ↓
/app/secrets/SECRET_KEY
```

---

## 5. Recommended deployment order

The safe order is:

1. Namespace
2. ConfigMap
3. Secret
4. PersistentVolume
5. PersistentVolumeClaim
6. Deployment
7. Services
8. HPA

This ensures that the Deployment starts only after its configuration and storage dependencies exist.

---

## 6. bootstrap.sh

Recommended `bootstrap.sh`:

```bash
#!/usr/bin/env bash

set -euo pipefail

kubectl apply -f .infrastructure/namespace.yml

kubectl apply -f .infrastructure/configMap.yml
kubectl apply -f .infrastructure/secret.yml

kubectl apply -f .infrastructure/pv.yml
kubectl apply -f .infrastructure/pvc.yml

kubectl apply -f .infrastructure/deployment.yml

kubectl apply -f .infrastructure/clusterIp.yml
kubectl apply -f .infrastructure/nodeport.yml

kubectl apply -f .infrastructure/hpa.yml
```

Make it executable:

```bash
chmod +x bootstrap.sh
```

Run it:

```bash
./bootstrap.sh
```

`set -euo pipefail` makes the script stop on errors instead of silently continuing with a partially deployed configuration.

---

## 7. Validate manifests before deployment

Check the YAML syntax and Kubernetes schema locally:

```bash
kubectl apply --dry-run=client -f .infrastructure/pv.yml
kubectl apply --dry-run=client -f .infrastructure/pvc.yml
kubectl apply --dry-run=client -f .infrastructure/configMap.yml
kubectl apply --dry-run=client -f .infrastructure/secret.yml
kubectl apply --dry-run=client -f .infrastructure/deployment.yml
```

All commands should complete without validation errors.

---

## 8. Validate PersistentVolume and PersistentVolumeClaim

Check the PV:

```bash
kubectl get pv
```

Check the PVC:

```bash
kubectl get pvc -n todoapp
```

Expected state:

```text
PV:   Bound
PVC:  Bound
```

Detailed information:

```bash
kubectl describe pv todo-pv
kubectl describe pvc todo-pvc -n todoapp
```

The PVC should be bound to:

```text
todo-pv
```

---

## 9. Validate that the application is running

Check the Deployment:

```bash
kubectl get deployment -n todoapp
```

Check Pods:

```bash
kubectl get pods -n todoapp
```

Check rollout:

```bash
kubectl rollout status deployment/todoapp -n todoapp
```

If a Pod is not running:

```bash
kubectl describe pod <POD_NAME> -n todoapp
```

Application logs:

```bash
kubectl logs -n todoapp deployment/todoapp
```

---

## 10. Validate the PVC mount

Get a Pod name:

```bash
kubectl get pods -n todoapp
```

Check `/app/data`:

```bash
kubectl exec -n todoapp <POD_NAME> -- ls -la /app/data
```

Create a test file:

```bash
kubectl exec -n todoapp <POD_NAME> -- sh -c 'echo "persistent storage works" > /app/data/test.txt'
```

Read it:

```bash
kubectl exec -n todoapp <POD_NAME> -- cat /app/data/test.txt
```

Expected:

```text
persistent storage works
```

---

## 11. Validate ConfigMap mounted as files

List the ConfigMap mount:

```bash
kubectl exec -n todoapp <POD_NAME> -- ls -la /app/configs
```

You should see a file named:

```text
PYTHONUNBUFFERED
```

Read it:

```bash
kubectl exec -n todoapp <POD_NAME> -- cat /app/configs/PYTHONUNBUFFERED
```

Expected:

```text
1
```

Check that the mount is read-only:

```bash
kubectl exec -n todoapp <POD_NAME> -- sh -c 'echo test > /app/configs/test.txt'
```

The command should fail because `/app/configs` is mounted read-only.

---

## 12. Validate Secret mounted as a file

List the Secret mount:

```bash
kubectl exec -n todoapp <POD_NAME> -- ls -la /app/secrets
```

You should see:

```text
SECRET_KEY
```

For security, do not print the secret value in normal logs.

Verify that the file exists and is not empty:

```bash
kubectl exec -n todoapp <POD_NAME> -- sh -c 'test -s /app/secrets/SECRET_KEY && echo "SECRET_KEY file is mounted"'
```

Expected:

```text
SECRET_KEY file is mounted
```

Check that the Secret mount is read-only:

```bash
kubectl exec -n todoapp <POD_NAME> -- sh -c 'echo test > /app/secrets/test.txt'
```

The command should fail.

---

## 13. Validate Services

Check services:

```bash
kubectl get svc -n todoapp
```

For local testing through NodePort:

```text
http://localhost:30007
```

Or test the Deployment directly using port-forward:

```bash
kubectl port-forward -n todoapp deployment/todoapp 8080:8080
```

Then:

```bash
curl http://localhost:8080/
```

Stop port-forward with:

```text
Ctrl+C
```

---

## 14. Useful troubleshooting commands

Show application resources:

```bash
kubectl get all -n todoapp
```

Show storage:

```bash
kubectl get pv
kubectl get pvc -n todoapp
```

Show configuration:

```bash
kubectl get configmap -n todoapp
kubectl get secret -n todoapp
```

Describe the Deployment:

```bash
kubectl describe deployment todoapp -n todoapp
```

Describe the PVC:

```bash
kubectl describe pvc todo-pvc -n todoapp
```

Show Pod events:

```bash
kubectl describe pod <POD_NAME> -n todoapp
```

---

## 15. Clean up

Delete namespaced resources:

```bash
kubectl delete namespace todoapp
```

Check the PV afterwards:

```bash
kubectl get pv
```

Because the PV uses `persistentVolumeReclaimPolicy: Delete`, verify its final state after deleting the claim.

If the PV remains because of local `hostPath` behavior, remove it explicitly:

```bash
kubectl delete pv todo-pv
```

---

## 16. Git / Pull Request

Before committing:

```bash
git status
```

Add only the task files:

```bash
git add .infrastructure/pv.yml
git add .infrastructure/pvc.yml
git add .infrastructure/configMap.yml
git add .infrastructure/secret.yml
git add .infrastructure/deployment.yml
git add bootstrap.sh
git add INSTRUCTION.md
```

Commit:

```bash
git commit -m "Add Kubernetes persistent volume configuration"
```

Push:

```bash
git push
```

Suggested PR title:

```text
Add Kubernetes persistent volumes and mounted configuration
```

Suggested PR description:

```markdown
## Changes

- Added PersistentVolume with 1Gi capacity
- Added PersistentVolumeClaim bound to the PersistentVolume
- Mounted persistent storage at `/app/data`
- Mounted ConfigMap as read-only files at `/app/configs`
- Mounted Secret as read-only files at `/app/secrets`
- Added bootstrap script for complete deployment
- Added deployment and validation instructions
```
