# Validation Instructions

## 1. Deploy the Application
Run the bootstrap script:
```bash
sh bootstrap.sh
```

## 2. Validate App Status

Check if the pods are in Running state:
```bash
kubectl get pods -n todoapp
```

## 3. Validate Volume Mounts
1. Get a Pod Name:
```bash
POD_NAME=$(kubectl get pods -n todoapp -l app=todoapp -o jsonpath="{.items[0].metadata.name}")
echo $POD_NAME
```

2. Validate Persistent Volume (/app/data):
```bash
kubectl exec $POD_NAME -n todoapp -- ls -d /app/data
kubectl exec $POD_NAME -n todoapp -- touch /app/data/test-file
kubectl exec $POD_NAME -n todoapp -- ls /app/data/test-file
```

3. Validate ConfigMap Mount (/app/configs):
```bash
kubectl exec $POD_NAME -n todoapp -- ls -l /app/configs
# Check content
kubectl exec $POD_NAME -n todoapp -- cat /app/configs/PYTHONUNBUFFERED
```

4. Validate Secret Mount (/app/secrets):
```bash
kubectl exec $POD_NAME -n todoapp -- ls -l /app/secrets
# Check content
kubectl exec $POD_NAME -n todoapp -- cat /app/secrets/SECRET_KEY
```