### Deployment

Run the bootstrap script to deploy all resources to the `todoapp` namespace

### Verify that the application pod has started successfully

```bash
kubectl get pods -n todoapp -l app=todoapp
```

### Get POD_NAME variable to use in next steps

```bash
kubectl get pods
```

### Validate ConfigMap mounted as files in the right order

```bash
kubectl exec "POD_NAME" -n todoapp -- ls -l /app/configs
```

### Validate Secret Mount

```bash
kubectl exec "POD_NAME" -n todoapp -- ls -l /app/secrets
```
