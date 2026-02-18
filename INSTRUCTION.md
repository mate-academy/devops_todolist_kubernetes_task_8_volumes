# Validation Instructions

Before validating, you must deploy all resources by running the bootstrap script:
```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

## 1. Verify App is Running
Check the status of the pods to ensure they are in the `Running` state:
```bash
kubectl get pods -n todoapp
```
## 2. Validate ConfigMap Data Mounts
Verify that the ConfigMap data is mounted as files in the /app/configs folder:
# List files to check the order and existence
```bash
kubectl exec -it <pod-name> -n todoapp -- ls /app/configs
```

# Check the content of a specific config file
```bash
kubectl exec -it <pod-name> -n todoapp -- cat /app/configs/PYTHONUNBUFFERED
```

## 3. Validate Secret Data Mounts
Verify that the Secret data is mounted as a file in the /app/secrets folder:
# List files in the secrets directory
```bash
kubectl exec -it <pod-name> -n todoapp -- ls /app/secrets
```
# Check the content of the secret file
```bash
kubectl exec -it <pod-name> -n todoapp -- cat /app/secrets/SECRET_KEY
```

## 4. Validate Persistent Volume Mount
Ensure the volume is correctly mounted at /app/data and is writable:
```bash
kubectl exec -it <pod-name> -n todoapp -- df -h | grep /app/data
```