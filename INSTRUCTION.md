# Validation

## 1. Deploy resources

Create the cluster if it does not exist yet:

```bash
kind create cluster --config cluster.yml
```

Deploy the application resources:

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

## 2. Check that the app is running

Wait until the deployment becomes available:

```bash
kubectl -n todoapp rollout status deployment/todoapp
```

Check pods and services:

```bash
kubectl -n todoapp get pods
kubectl -n todoapp get svc
```

Open the application through the NodePort service:

```bash
curl http://localhost:30007/
curl http://localhost:30007/api/health
```

## 3. Check that ConfigMap data is mounted as files in the right order

List files in the mounted config directory:

```bash
kubectl -n todoapp exec deployment/todoapp -- ls -1 /app/configs
```

Expected output should include:

```text
01-pythonunbuffered
```

Inspect the file content:

```bash
kubectl -n todoapp exec deployment/todoapp -- cat /app/configs/01-pythonunbuffered
```

Expected value:

```text
1
```

## 4. Check that Secret data is mounted as a file

List files in the mounted secret directory:

```bash
kubectl -n todoapp exec deployment/todoapp -- ls -1 /app/secrets
```

Expected output should include:

```text
01-secret-key
```

Inspect the mounted secret file:

```bash
kubectl -n todoapp exec deployment/todoapp -- cat /app/secrets/01-secret-key
```

The command should print the decoded secret value.

## 5. Check that persistent storage is mounted

Verify the PVC is bound:

```bash
kubectl -n todoapp get pvc
kubectl get pv
```

Verify the volume mount inside the container:

```bash
kubectl -n todoapp exec deployment/todoapp -- sh -c 'mount | grep /app/data || true'
kubectl -n todoapp exec deployment/todoapp -- ls -la /app/data
```
