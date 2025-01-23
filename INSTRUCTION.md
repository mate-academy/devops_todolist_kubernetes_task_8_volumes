# Validation Instructions

1. **Verify that the app is running:**
   Run the command:
```bash
   kubectl get pods
```
Ensure the pod is in Running state.

2. Verify that PersistentVolumeClaim is bound: Run the command:
```bash
kubectl get pvc
```
Ensure the status is Bound.

3. Verify that ConfigMap data is mounted as files: Enter the pod:
```bash
kubectl exec -it <pod-name> -- /bin/bash
```
Check the /app/configs folder to ensure files from the ConfigMap are present.

4. Verify that Secret data is mounted as files: Check the /app/secrets folder to ensure files from the Secret are present.
5. Check PersistentVolume mount: Verify that the /app/data folder is writable and persists data.
