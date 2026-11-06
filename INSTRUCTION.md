# Kubernetes Persistent Volumes Instructions

## 1. Overview

This Django ToDo application is deployed to a Kubernetes cluster in the `todoapp` namespace.

This task adds persistent storage to the application using Kubernetes `PersistentVolume` and `PersistentVolumeClaim` resources.

The storage configuration uses:

- PersistentVolume name: `pv-data`
- PersistentVolumeClaim name: `pvc-data`
- Storage capacity: `1Gi`
- Storage class: `standard`
- Access mode: `ReadWriteMany`
- Reclaim policy: `Delete`
- PersistentVolume type: `hostPath`
- Host path on the Kubernetes node: `/data/`
- Mount path inside the application container: `/app/data`

The application also mounts:

- ConfigMap `app-config` as read-only files in `/app/configs`
- Secret `app-secret` as read-only files in `/app/secrets`

The Deployment uses the image:

```text
ikulyk404/todoapp:3.0.0
```

---

## 2. Create and Select the Namespace

If the `todoapp` namespace does not exist, create it:

```bash
kubectl create namespace todoapp
```

Set `todoapp` as the default namespace for the current Kubernetes context:

```bash
kubectl config set-context --current --namespace=todoapp
```

Verify the currently selected namespace:

```bash
kubectl config view --minify -o jsonpath='{..namespace}{"\n"}'
```

---

## 3. Deploy the Application

All commands required to deploy the resources are collected in the `bootstrap.sh` file located in the project root.

The script contains:

```bash
#!/bin/bash

kubectl apply -f ./.infrastructure/configMap.yml
kubectl apply -f ./.infrastructure/secret.yml

kubectl apply -f ./.infrastructure/clusterIp.yml
kubectl apply -f ./.infrastructure/hpa.yml
kubectl apply -f ./.infrastructure/nodeport.yml

kubectl apply -f ./.infrastructure/pv.yml
kubectl apply -f ./.infrastructure/pvc.yml

kubectl apply -f ./.infrastructure/deployment.yml
```

Make the script executable:

```bash
chmod +x bootstrap.sh
```

Run the script from the project root:

```bash
./bootstrap.sh
```

The PersistentVolume and PersistentVolumeClaim are created before the Deployment, so the application Pods can mount the requested storage when they start.

---

## 4. Validate the Application

Check the application Pods:

```bash
kubectl get pods
```

The Pods should be in the `Running` state and show `1/1` in the `READY` column.

Check the Deployment:

```bash
kubectl get deployment
```

Check the services:

```bash
kubectl get services
```

The application is exposed through the NodePort service on port `30007`.

Open the application in a browser:

```text
http://localhost:30007/
```

---

## 5. Validate PersistentVolume and PersistentVolumeClaim

Check the PersistentVolume:

```bash
kubectl get pv
```

Check the PersistentVolumeClaim:

```bash
kubectl get pvc
```

Both resources should show the `Bound` status.

For detailed information, use:

```bash
kubectl describe pv pv-data
kubectl describe pvc pvc-data
```

The PersistentVolume should have:

```text
Capacity:       1Gi
Access Modes:   RWX
Reclaim Policy: Delete
Storage Class:  standard
```

The PersistentVolumeClaim should be bound to `pv-data`.

The storage path is different on the Kubernetes node and inside the application container:

```text
Kubernetes node: /data/
        ↓
PersistentVolume / PersistentVolumeClaim
        ↓
Application container: /app/data
```

---

## 6. Validate the Persistent Volume Mount

First, get the name of an application Pod:

```bash
kubectl get pods
```

Open a shell inside one of the application Pods:

```bash
kubectl exec -it <pod-name> -- sh
```

Check that the volume is mounted at `/app/data`:

```bash
mount | grep /app/data
```

Check the directory:

```bash
ls -la /app/data
```

You can also create a test file:

```bash
echo "persistent-volume-test" > /app/data/test.txt
cat /app/data/test.txt
```

Exit the container:

```bash
exit
```

The `/app/data` directory is backed by `pvc-data`, which claims the `pv-data` PersistentVolume.

---

## 7. Validate the ConfigMap File Mount

The existing ConfigMap `app-config` is mounted as read-only files into:

```text
/app/configs
```

Open a shell inside an application Pod:

```bash
kubectl exec -it <pod-name> -- sh
```

Check the mounted files:

```bash
ls -la /app/configs
```

Verify the mounted ConfigMap value:

```bash
cat /app/configs/PYTHONUNBUFFERED
```

Expected value:

```text
1
```

Check the mount:

```bash
mount | grep /app/configs
```

Exit the container:

```bash
exit
```

---

## 8. Validate the Secret File Mount

The existing Secret `app-secret` is mounted as read-only files into:

```text
/app/secrets
```

Open a shell inside an application Pod:

```bash
kubectl exec -it <pod-name> -- sh
```

Check the mounted files:

```bash
ls -la /app/secrets
```

The directory should contain the file created from the Secret key:

```text
SECRET_KEY
```

For validation, it is enough to check that the file exists and is not empty:

```bash
test -s /app/secrets/SECRET_KEY && echo "SECRET_KEY file is mounted"
```

Expected output:

```text
SECRET_KEY file is mounted
```

Check the mount:

```bash
mount | grep /app/secrets
```

Exit the container:

```bash
exit
```

---

## 9. Troubleshooting

If an application Pod remains in the `Pending` state, inspect it:

```bash
kubectl describe pod <pod-name>
```

Pay attention to the `Events` section.

If the message contains:

```text
pod has unbound immediate PersistentVolumeClaims
```

check the PersistentVolume and PersistentVolumeClaim:

```bash
kubectl get pv
kubectl get pvc
kubectl describe pv pv-data
kubectl describe pvc pvc-data
```

The `pv-data` PersistentVolume and `pvc-data` PersistentVolumeClaim must be successfully bound before the application Pods can use `/app/data`.

---

## 10. Final Verification

Run:

```bash
kubectl get pods
kubectl get deployments
kubectl get services
kubectl get pv
kubectl get pvc
kubectl get configmaps
kubectl get secrets
```

Validate that:

- application Pods are `Running` and `Ready`;
- the application is available at `http://localhost:30007/`;
- `pv-data` has a capacity of `1Gi`;
- `pv-data` uses `ReadWriteMany`, `standard`, `Delete`, and `hostPath`;
- `pv-data` and `pvc-data` are `Bound`;
- the persistent volume is mounted inside the application container at `/app/data`;
- ConfigMap data is mounted as read-only files in `/app/configs`;
- Secret data is mounted as read-only files in `/app/secrets`.


