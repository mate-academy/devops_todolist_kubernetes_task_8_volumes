## Check, if pod is alive:

```bash
kubectl get pods -n todoapp
```

## Mapping configMap to container:

```bash
kubectl exec -it <pod-name> -n todoapp -- ls /app/configs
```

## Mapping secret:

```bash
kubectl exec -it <pod-name> -n todoapp -- ls /app/secrets
```

# Data in /app/data (from PV) you can check the same method
