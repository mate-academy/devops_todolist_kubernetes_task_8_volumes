# ToDo App Persistent Volumes and Config Mounts

## 1. How to deploy all resources
Run the provided bootstrap script to deploy the namespace, persistent volumes, configurations, and the application in the correct order. 
*(Note for Windows users: run `sh bootstrap.sh` instead of `./bootstrap.sh`)*:
```bash
sh bootstrap.sh
```

## 2. Architecture & Best Practices Rationale
The storage configuration for this task is designed to meet the specific requirements, while keeping modern K8s best practices in mind:
* **Storage Provisioning (PV/PVC):** We use a manual `PersistentVolume` with `hostPath` as required by the task constraints (suitable for local testing like Kind/Minikube). In a modern production environment, we would rely on **Dynamic Provisioning via CSI drivers** (e.g., AWS EBS CSI) where the cloud provider automatically creates the physical disk and PV based on the PVC request.
* **Access Modes:** The PV is configured with `ReadWriteMany` to satisfy the task requirements. However, for exclusive database or stateful pod access in modern clusters (Kubernetes v1.29+), **ReadWriteOncePod (RWOP)** is the GA standard to prevent filesystem corruption by ensuring only one specific pod across the entire cluster can write to the volume.
* **ConfigMap & Secret File Mounts:** Mounting `configMap` and `secret` as read-only files (instead of environment variables) is a K8s best practice for configurations. Unlike environment variables, which require a pod restart to update, mounted files are automatically updated by K8s when the underlying ConfigMap/Secret changes.

## 3. How to validate the solution

### 3.1. Validate App is running & PVC is bound
Ensure the pods are `Running` and the PVC has successfully claimed the PersistentVolume (`STATUS: Bound`):
```bash
kubectl get pods -n mateapp
kubectl get pv,pvc -n mateapp
```

### 3.2. Validate ConfigMap data is mounted as a file
Execute into the pod and read the ConfigMap file mounted in `/app/configs`.
```bash
# 1. Get the pod name
kubectl get pods -n mateapp -l app=todolist

# 2. List the contents of the configs directory (replace <pod-name>)
kubectl exec -it <pod-name> -n mateapp -- ls -l /app/configs

# 3. Check the content of the mounted config file
kubectl exec -it <pod-name> -n mateapp -- cat /app/configs/PYTHONUNBUFFERED
```
*Expected Output:* The console should print `1`.

### 3.3. Validate Secret data is mounted as a file
Verify that the sensitive data is correctly mounted as a read-only file in `/app/secrets`.
```bash
# 1. List the contents of the secrets directory
kubectl exec -it <pod-name> -n mateapp -- ls -l /app/secrets

# 2. Read the secret key file directly from the mount
kubectl exec -it <pod-name> -n mateapp -- cat /app/secrets/SECRET_KEY
```
*Expected Output:* The console should print the actual Secret Key string safely from the file system.