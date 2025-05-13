# Validation Instructions

## 1. Verify App is Running
```bash
# Check if pods are running
kubectl get pods -l app=todoapp

# Check pod logs
kubectl logs -l app=todoapp
```

## 2. Verify ConfigMap Mount
```bash
# Get into the pod
kubectl exec -it $(kubectl get pod -l app=todoapp -o jsonpath="{.items[0].metadata.name}") -- /bin/sh

# Check ConfigMap mount
ls -la /app/configs
cat /app/configs/*

exit
```

## 3. Verify Secrets Mount
```bash
# Get into the pod
kubectl exec -it $(kubectl get pod -l app=todoapp -o jsonpath="{.items[0].metadata.name}") -- /bin/sh

# Check Secrets mount
ls -la /app/secrets
cat /app/secrets/*

exit
```

## 4. Verify PersistentVolume Mount
```bash
# Get into the pod
kubectl exec -it $(kubectl get pod -l app=todoapp -o jsonpath="{.items[0].metadata.name}") -- /bin/sh

# Check PV mount
ls -la /app/data
touch /app/data/test.txt
ls -la /app/data

exit
``` 