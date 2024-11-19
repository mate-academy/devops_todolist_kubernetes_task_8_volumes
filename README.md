# Persistent Volume (PV) and Persistent Volume (PVC) for TodoApp

## 1. Apply all the manifests using the bootstrap.sh script:

```bash
./bootstrap.sh
```

## 2. Wait for about 1 minute for pods, services, and volumes to start. Check their status:
```bash
kubectl get pods -n todoapp
kubectl get pv
kubectl get pvc -n todoapp
```
Pods should have a "Running" status. PV and PVC statuses should be "Bound," indicating that they have been successfully connected.

## 3. Connect to one of the pods and check if the volumes are mounted:
```bash
kubectl exec <pod_name> -n todoapp -it -- sh
ls /app/secrets
ls /app/configs
```
If the last two commands return the file names, then your volumes are mounted correctly.
