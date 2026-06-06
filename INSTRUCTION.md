# Todoapp Kubernetes Deployment - Validation Instructions

## Prerequisites

Ensure the cluster is running and all resources are deployed:

```bash
bash bootstrap.sh
```

---

## 1. Validate That the App Is Running

Check that all pods are in `Running` state and fully ready:

```bash
kubectl get pods -n todoapp
```

Expected output — both `READY` and `STATUS` columns should show `1/1` and `Running`:

```
NAME                       READY   STATUS    RESTARTS   AGE
todoapp-xxxxxxxxxx-xxxxx   1/1     Running   0          Xm
todoapp-xxxxxxxxxx-xxxxx   1/1     Running   0          Xm
```

Verify the service is available:

```bash
kubectl get svc -n todoapp
```

Forward the port and open the app in a browser:

```bash
kubectl port-forward svc/todoapp-nodeport 8080:80 -n todoapp
```

Open [http://localhost:8080](http://localhost:8080) — the todoapp UI should load.

Check the health and readiness endpoints:

```bash
curl http://localhost:8080/api/health
curl http://localhost:8080/api/ready
```

Both should return HTTP `200`.

---

## 2. Validate That ConfigMap Data Is Mounted as Files

Get the name of a running pod:

```bash
kubectl get pods -n todoapp
```

Exec into the pod and list files inside `/app/configs`:

```bash
kubectl exec -it <pod-name> -n todoapp -- ls -la /app/configs
```

Each key defined in the `app-config` ConfigMap should appear as a separate file. For example, if the ConfigMap has a key `PYTHONUNBUFFERED`, you should see:

```
-rw-r--r-- 1 root root  1 Jun  7 00:00 PYTHONUNBUFFERED
```

Verify the contents of a specific file:

```bash
kubectl exec -it <pod-name> -n todoapp -- cat /app/configs/PYTHONUNBUFFERED
```

---

## 3. Validate That Secret Data Is Mounted as a File

Exec into the pod and list files inside `/app/secrets`:

```bash
kubectl exec -it <pod-name> -n todoapp -- ls -la /app/secrets
```

Each key defined in the `app-secret` Secret should appear as a separate file. For example:

```
-rw-r--r-- 1 root root  X Jun  7 00:00 SECRET_KEY
```

Verify the file exists and has content:

```bash
kubectl exec -it <pod-name> -n todoapp -- cat /app/secrets/SECRET_KEY
```

---

## 4. Validate PersistentVolume and PersistentVolumeClaim

Check that the PV and PVC are bound to each other:

```bash
kubectl get pv
kubectl get pvc -n todoapp
```

Expected — both should show `STATUS: Bound`:

```
NAME           CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                  STORAGECLASS
todo-pv-data   1Gi        RWX            Delete           Bound    todoapp/pvc-data        standard

NAME       STATUS   VOLUME         CAPACITY   ACCESS MODES   STORAGECLASS
pvc-data   Bound    todo-pv-data   1Gi        RWX            standard
```

Verify the `/app/data` mount inside the pod:

```bash
kubectl exec -it <pod-name> -n todoapp -- ls -la /app/data
```
