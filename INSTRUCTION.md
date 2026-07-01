# Validation Instructions

## 1. App is running
```bash
kubectl get pods
# Verify that the status is Running
kubectl logs <pod-name>
```

## 2. ConfigMap data is mounted as files in the right order
```bash
# List files in /app/configs (displayed in alphabetical order)
kubectl exec -it <pod-name> -- ls /app/configs

# Check the contents of a specific file
kubectl exec -it <pod-name> -- cat /app/configs/<key-name>
```
> Files are displayed in **alphabetical order** by ConfigMap keys.
> Expected files: `<key1>`, `<key2>` (replace with the actual keys of your ConfigMap)

## 3. Secret data is mounted as a file
```bash
kubectl exec -it <pod-name> -- ls /app/secrets
kubectl exec -it <pod-name> -- cat /app/secrets/<secret-key>
```