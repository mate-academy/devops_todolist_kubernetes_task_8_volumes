# Instructions to Deploy and Validate

## Deploy All Resources

Run the bootstrap script to deploy all resources to the cluster:

```bash
bash bootstrap.sh
```

This will apply all resources in the correct order:
1. Namespace
2. PersistentVolume
3. PersistentVolumeClaim
4. ConfigMap
5. Secret
6. Deployment
7. Services (ClusterIP and NodePort)
8. HorizontalPodAutoscaler

## Validation Steps

### 1. Verify App is Running

Check if the deployment is running:

```bash
kubectl get deployment todoapp -n todoapp
```

Check if pods are running:

```bash
kubectl get pods -n todoapp
```

Get the pod name for further validation:

```bash
export POD_NAME=$(kubectl get pods -n todoapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}')
echo $POD_NAME
```

Check if the app is accessible:

```bash
kubectl port-forward -n todoapp $POD_NAME 8080:8080
```

Then open http://localhost:8080 in your browser or use curl:

```bash
curl http://localhost:8080/api/health
```

### 2. Verify ConfigMap Data is Mounted as Files

Check if ConfigMap is mounted in the `/app/configs` folder:

```bash
kubectl exec -it $POD_NAME -n todoapp -- ls -la /app/configs
```

View the ConfigMap file contents (should show PYTHONUNBUFFERED value):

```bash
kubectl exec -it $POD_NAME -n todoapp -- cat /app/configs/PYTHONUNBUFFERED
```

Verify it's read-only:

```bash
kubectl exec -it $POD_NAME -n todoapp -- sh -c "touch /app/configs/test" 2>&1 | grep -i "read-only"
```

### 3. Verify Secret Data is Mounted as Files

Check if Secret is mounted in the `/app/secrets` folder:

```bash
kubectl exec -it $POD_NAME -n todoapp -- ls -la /app/secrets
```

View the Secret file contents (should show SECRET_KEY value):

```bash
kubectl exec -it $POD_NAME -n todoapp -- cat /app/secrets/SECRET_KEY
```

Verify it's read-only:

```bash
kubectl exec -it $POD_NAME -n todoapp -- sh -c "touch /app/secrets/test" 2>&1 | grep -i "read-only"
```

### 4. Verify PersistentVolume and PersistentVolumeClaim

Check PersistentVolume status:

```bash
kubectl get pv
```

Check PersistentVolumeClaim status:

```bash
kubectl get pvc -n todoapp
```

Verify PV is bound to PVC:

```bash
kubectl describe pv todoapp-pv
```

Check if the volume is mounted at `/app/data`:

```bash
kubectl exec -it $POD_NAME -n todoapp -- ls -la /app/data
```

Test write access to the PersistentVolume:

```bash
kubectl exec -it $POD_NAME -n todoapp -- sh -c "echo 'test' > /app/data/test.txt"
kubectl exec -it $POD_NAME -n todoapp -- cat /app/data/test.txt
```

### 5. Verify Volume Mount Details

Get detailed information about volume mounts in the pod:

```bash
kubectl describe pod $POD_NAME -n todoapp | grep -A 10 "Mounts:"
```

## Cleanup

To remove all resources:

```bash
kubectl delete namespace todoapp
kubectl delete pv todoapp-pv
```
