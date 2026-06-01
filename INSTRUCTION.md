# ToDo Application Deployment Validation

## Deploy Resources

Run:

```bash
./bootstrap.sh
```

or

```bash
kubectl apply -f pv.yml
kubectl apply -f pvc.yml
kubectl apply -f deployment.yml
```

---

## Validate Application is Running

Check deployment:

```bash
kubectl get deployments
```

Check pod:

```bash
kubectl get pods
```

Verify pod status is Running.

---

## Validate PersistentVolume and PersistentVolumeClaim

```bash
kubectl get pv
kubectl get pvc
```

Expected:

- PV status: Bound
- PVC status: Bound

---

## Validate PersistentVolume Mount

Get pod name:

```bash
kubectl get pods
```

Inspect mount:

```bash
kubectl exec -it <pod-name> -- ls -la /app/data
```

The directory should exist and be writable.

Test write:

```bash
kubectl exec -it <pod-name> -- sh -c "echo test > /app/data/test.txt"
kubectl exec -it <pod-name> -- cat /app/data/test.txt
```

Expected output:

```text
test
```

---

## Validate ConfigMap Mount

List files:

```bash
kubectl exec -it <pod-name> -- ls -la /app/configs
```

View contents:

```bash
kubectl exec -it <pod-name> -- cat /app/configs/*
```

Expected:

- ConfigMap keys are mounted as files.
- Files appear in `/app/configs`.
- Mount is read-only.

Verify read-only:

```bash
kubectl exec -it <pod-name> -- touch /app/configs/test
```

Expected: Permission denied.

---

## Validate Secret Mount

List secret files:

```bash
kubectl exec -it <pod-name> -- ls -la /app/secrets
```

View secret contents:

```bash
kubectl exec -it <pod-name> -- cat /app/secrets/*
```

Expected:

- Secret keys are mounted as files.
- Files exist under `/app/secrets`.
- Mount is read-only.

Verify read-only:

```bash
kubectl exec -it <pod-name> -- touch /app/secrets/test
```

Expected: Permission denied.

---

## Validate Deployment Uses PVC

```bash
kubectl describe pod <pod-name>
```

Verify:

- PVC `todo-pvc` is mounted.
- Mount path is `/app/data`.
