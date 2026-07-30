### Deployment

To apply the configuration, secrets, and deploy the application, execute the following script from the root of the repository:
`bash bootstrap.sh`

Or run them by yourself
```bash
kubectl apply -f .infrastructure/pv.yml
```

```bash
kubectl apply -f .infrastructure/pvc.yml
```

```bash
kubectl apply -f .infrastructure/configMap.yml
```

```bash
kubectl apply -f .infrastructure/secret.yml
```

```bash
kubectl apply -f .infrastructure/deployment.yml
```

### Validation

**Check Pod Status:**

```bash
kubectl get pods -n todoapp
```

```bash
kubectl exec -n todoapp -it <pod-name> -- sh
```
### Verify the application is running by checking the health endpoint:

```bash
curl http://localhost:8080/api/health
```

### Check the mounted directories and read the files:

```bash
ls -l
```

```bash
cat /app/configs/PYTHONUNBUFFERED

cat /app/secrets/SECRET_KEY
```





