## Kubernetes task 8 — Volumes

### Deploy everything

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

Or apply manually:

```bash
kubectl apply -f .infrastructure/namespace.yml
kubectl apply -f .infrastructure/pv.yml
kubectl apply -f .infrastructure/pvc.yml
kubectl apply -f .infrastructure/confgiMap.yml
kubectl apply -f .infrastructure/secret.yml
kubectl apply -f .infrastructure/deployment.yml
kubectl apply -f .infrastructure/clusterIp.yml
```

### Validate: app is running

```bash
kubectl -n todoapp get deploy,pods,pvc,pv,svc
kubectl -n todoapp describe pvc todoapp-pvc
```

Port-forward the service:

```bash
kubectl -n todoapp port-forward svc/todoapp-service 8080:80
```

In another terminal:

```bash
curl -i http://localhost:8080/api/ready
curl -i http://localhost:8080/api/health
```

### Validate: ConfigMap and Secret are mounted as files
Get a pod name:

```bash
kubectl -n todoapp get pods
```

List mounted files:

```bash
kubectl -n todoapp exec -it pod/<POD_NAME> -- ls -la /app/configs
kubectl -n todoapp exec -it pod/<POD_NAME> -- ls -la /app/secrets
```

Expected:
- **ConfigMap**: `/app/configs/PYTHONUNBUFFERED` file exists and contains `1`
- **Secret**: `/app/secrets/SECRET_KEY` file exists (content is base64-decoded by K8s)

Check file contents:

```bash
kubectl -n todoapp exec -it pod/<POD_NAME> -- cat /app/configs/PYTHONUNBUFFERED
kubectl -n todoapp exec -it pod/<POD_NAME> -- cat /app/secrets/SECRET_KEY
```

