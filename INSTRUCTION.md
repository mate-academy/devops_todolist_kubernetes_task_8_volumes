# Instructions to Validate the ToDo App Deployment

This document provides steps to validate that the ToDo app is running correctly in your Kubernetes cluster and that ConfigMap and Secret data are mounted properly.

## 1. Verify Namespace

Check that the `todoapp` namespace exists:

```bash
kubectl get namespaces
```

You should see `todoapp` in the list.

---

## 2. Verify PersistentVolume (PV) and PersistentVolumeClaim (PVC)

Check that the PersistentVolume `pv-data` is created:

```bash
kubectl get pv
```

* `STATUS` should be `Available` or `Bound`.
* `CAPACITY` should be `1Gi`.
* `ACCESS MODES` should include `ReadWriteMany`.

Check that the PersistentVolumeClaim `pvc-data` is created and bound:

```bash
kubectl get pvc -n todoapp
```

* `STATUS` should be `Bound`.
* `VOLUME` should be `pv-data`.

---

## 3. Verify ConfigMap and Secret

Check that the ConfigMap `app-config` exists:

```bash
kubectl get configmap -n todoapp
kubectl describe configmap app-config -n todoapp
```

Check that the Secret `app-secret` exists:

```bash
kubectl get secret -n todoapp
kubectl describe secret app-secret -n todoapp
```

---

## 4. Verify Deployment and Pod Status

Check that the deployment is running:

```bash
kubectl get deployments -n todoapp
```

Check that the pod is running:

```bash
kubectl get pods -n todoapp
```

* `STATUS` should be `Running`.
* If using liveness and readiness probes, ensure both probes pass.

Check pod details:

```bash
kubectl describe pod <pod-name> -n todoapp
```

---

## 5. Verify ConfigMap and Secret Mounts Inside the Pod

Open a shell inside the pod:

```bash
kubectl exec -it <pod-name> -n todoapp -- /bin/sh
```

### Check ConfigMap Mount

```bash
ls -l /app/configs
cat /app/configs/PYTHONUNBUFFERED
```

* You should see a file named `PYTHONUNBUFFERED`.
* Its content should match the value from `app-config` (should be `1`).

### Check Secret Mount

```bash
ls -l /app/secrets
cat /app/secrets/SECRET_KEY
```

* You should see a file named `SECRET_KEY`.
* Its content should match the value from `app-secret`.
* 
```bash
exit
```

---

## 6. Verify ToDo App API

If the pod is running on port 8080, you can port-forward to your local machine:

```bash
kubectl port-forward <pod-name> 8080:8080 -n todoapp
```

Then, test the endpoints:

* Health check:

```bash
curl http://localhost:8080/api/health
```

* Readiness check:

```bash
curl http://localhost:8080/api/ready
```

Both should return a successful status (e.g., HTTP 200).
