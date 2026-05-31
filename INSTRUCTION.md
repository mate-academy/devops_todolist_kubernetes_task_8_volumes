# Validation Instructions

This document provides instructions on how to validate that the ToDo application and its resources are deployed and configured correctly.

---

## 1. Verify App is Running

To ensure that the application deployment was successful and the Pod is running, execute the following commands:

```
# Check the status of the Deployment
kubectl get deployment todoapp
```

```
# Check the status of the Pods
kubectl get pods -l app=todoapp
```
```
# Check the status of the PersistentVolumeClaim
kubectl get pvc pvc-data
```
Validation criteria: The deployment should show 1/1 ready replicas, the pod status must be Running, and the PVC status must be Bound.

## 2. Verify ConfigMap Data Mounting
To validate that the ConfigMap data is correctly mounted as files in the /app/configs folder in the correct order and is read-only, run:

```
# Get the pod name
POD_NAME=$(kubectl get pods -l app=todoapp -o jsonpath='{.items[0].metadata.name}')
```
```
# List the files in the config directory
kubectl exec -it $POD_NAME -- ls -la /app/configs
```
```
# Verify the mount is Read-Only (this command should return a 'Read-only file system' error)
kubectl exec -it $POD_NAME -- touch /app/configs/test_write.txt
```
## 3. Verify Secret Data Mounting
To validate that the Secret data is correctly mounted as a file in the /app/secrets folder and is read-only, run:

```
# List the files in the secrets directory
kubectl exec -it $POD_NAME -- ls -la /app/secrets
```
```
# Verify the mount is Read-Only (this command should also return a 'Read-only file system' error)
kubectl exec -it $POD_NAME -- touch /app/secrets/test_write.txt
```
## 4. Verify Persistent Volume Mount Path
To verify that the Persistent Volume is correctly mounted to the /app/data directory, you can check the storage path inside the container:

```
# Check if the /app/data directory exists and is writable for the app
kubectl exec -it $POD_NAME -- df -h /app/data
```