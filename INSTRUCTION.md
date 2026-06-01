## Instruction for validation the deployment of the ToDo application
Follow these steps to verify that all resources in the cluster are working properly.
---
### 1. Check Pod status(Apps running)
Make sure that the pod with the application has started successfully and is in the Running status:
```bash
kubectl get pods
```

2. Verifying the ConfigMap mount
```bash
kubectl exec -it <pod-name> -- ls -la /app/configs
```
 Check that the contents of the configuration files:
 ```bash
kubectl exec -it <pod-name> -- cat /app/configs/your-config-key
```
Check that the file-system in write-protected (Read-only):
```bash
kubectl exec -it <pod-name> -- touch /app/configs/test.txt
```
3. Check the mounting of the secret:
1. View the list of files in the secrets directory:
```bash
kubectl exec -it <pod-name> -- touch /app/secrets/test.txt
```
2. Check that the secrets are mounted correctly:
```bash
kubectl exec -it <pod-name> -- cat /app/secrets/your-secret-key
```
3. Check for head-only access:
```bash
kubectl exec -it <pod-name> -- touch /app/secrets/test.txt
```