# INSTRUCTION

## Task 8: Working with Volumes

This document describes how to validate the Kubernetes volumes configuration for the ToDo application.

### 1. Check the application Deployment and Pods

Verify that the Deployment exists and the application Pods are running in the `mateapp` namespace.

```powershell
kubectl get deployments -n mateapp
kubectl get pods -n mateapp
```

### 2. Check the PersistentVolume

Verify that the PersistentVolume exists and has the expected configuration.

```powershell
kubectl get pv
kubectl describe pv
```

Check the storage capacity, access modes, storage class, reclaim policy, and status.

### 3. Check the PersistentVolumeClaim

Verify that the application's PVC is bound to a PersistentVolume.

```powershell
kubectl get pvc -n mateapp
kubectl describe pvc -n mateapp
```

The PVC should have status `Bound`.

### 4. Check the ConfigMap

Verify that the application ConfigMap exists and contains the expected configuration.

```powershell
kubectl get configmap -n mateapp
kubectl describe configmap app-config -n mateapp
```

### 5. Check the mounted volumes

Inspect the application Pod to verify the configured volume mounts.

```powershell
kubectl describe pods -n mateapp
```

The application should mount persistent storage at `/app/data`, the ConfigMap at `/app/configs`, and the Secret at `/app/secrets`, according to the Deployment configuration.

### 6. Verify the ConfigMap files inside the container

List the files mounted from the ConfigMap:

```powershell
kubectl exec -n mateapp deployment/todoapp -- ls -la /app/configs
```

Display the contents of the mounted files:

```powershell
kubectl exec -n mateapp deployment/todoapp -- sh -c 'for f in /app/configs/*; do echo "=== $f"; cat "$f"; done'
```

The mounted filenames and contents should match the keys and values defined in the `app-config` ConfigMap.

### 7. Verify the Secret mount

Check that the Secret volume is configured in the Pod:

```powershell
kubectl describe pods -n mateapp
```

The Secret should be mounted at `/app/secrets` as read-only, according to the Deployment configuration. Do not print or publish secret values.

### 8. Final validation

Run the following commands to review the resources:

```powershell
kubectl get deployments,pods,services -n mateapp
kubectl get pv
kubectl get pvc -n mateapp
kubectl get configmap,secret -n mateapp
```

Confirm that the application Pods are running, the PVC is bound, and the configured volumes are mounted correctly.
