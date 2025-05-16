## 1. App is running

# PersistentVolume and PersistentVolumeClaim use hostPath with ReadWriteMany, which is only supported in local, single-node clusters

```bash
kubectl get pods -l app=todoapp

kubectl logs -l app=todoapp
```

## 2. ConfigMap Mount
```bash
kubectl exec -it todoapp-86764b9d75-bqrgr -- bash

ls -la /app/configs
cat /app/configs/*

exit
```

## 3. Secrets Mount
```bash
kubectl exec -it todoapp-86764b9d75-bqrgr -- bash


ls -la /app/secrets
cat /app/secrets/*

exit
```
