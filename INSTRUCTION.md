# Instructions for Storage, ConfigMap and Secret Volume Mounts

## 1. How to Deploy the Application
Run the automated bootstrap script from the root directory:

```bash
./bootstrap.sh
```

---

## 2. How to Validate the Solution

### Step 2.1: Verify App is Running
```bash
kubectl get deployment todoapp-deployment -n mateapp
kubectl get pods -n mateapp -l app:todolist
```

### Step 2.2: Verify ConfigMap is Mounted as Read-Only Files
Execute a directory listing inside one of the running pods to verify files exist in `/app/configs`:
```bash
kubectl exec -it deployment/todoapp-deployment -n mateapp -- ls -la /app/configs
```
*Expected output: You should see a file named `PYTHONUNBUFFERED` inside that folder.*

### Step 2.3: Verify Secret Data is Mounted as a File
Check the contents of the secrets directory:
```bash
kubectl exec -it deployment/todoapp-deployment -n mateapp -- ls -la /app/secrets
kubectl exec -it deployment/todoapp-deployment -n mateapp -- cat /app/secrets/SECRET_KEY
```
*Expected output: Should display the unencoded value of your Django secret key.*
