Check the Deployment:

```bash
kubectl get deployments -n todoapp
```

Check Pods:

```bash
kubectl get pods -n todoapp
```

To check the application using port forwarding:

```bash
kubectl port-forward -n todoapp deployment/todoapp 8080:8080
```
Validate PersistentVolume

```bash
kubectl get pv
```

Check the PersistentVolume details:

```bash
kubectl describe pv pv
```

Validate PersistentVolumeClaim

```bash
kubectl get pvc -n todoapp
```

```bash
kubectl describe pvc pvc -n todoapp
```


Test writing data:

```bash
kubectl exec -n todoapp deployment/todoapp -- sh -c 'echo volume-ok > /app/data/test.txt'
```

Read the file:

```bash
kubectl exec -n todoapp deployment/todoapp -- cat /app/data/test.txt
```

Check the mounted files:

```bash
kubectl exec -n todoapp deployment/todoapp -- ls -la /app/configs
```

Check the ConfigMap value:

```bash
kubectl exec -n todoapp deployment/todoapp -- cat /app/configs/PYTHONUNBUFFERED
```
Validate Secret Mount

```bash
kubectl exec -n todoapp deployment/todoapp -- ls -la /app/secrets
```
Validate Read-Only Mounts

```bash
kubectl get deployment todoapp -n todoapp -o yaml
```