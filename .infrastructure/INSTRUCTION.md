# INSTRUCTION.md

## How to deploy the application

1. Run the `bootstrap.sh` script to create all necessary resources:

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

## How to validate the application is running

1. Check that the pods are up and running:

```bash
kubectl get pods -n todoapp
```

2. Get the Node IP and the port if using NodePort:

```bash
kubectl get svc -n todoapp
```

3. Validate the app is reachable:

```bash
curl http://<NODE_IP>:30007/api/health
```

Expected: `200 OK` response

## Validate that ConfigMap data is mounted correctly as files

1. Get the name of the pod:

```bash
kubectl get pods -n todoapp
```

2. List files in the `/app/configs` directory:

```bash
kubectl exec -n todoapp <POD_NAME> -- ls /app/configs
```

Expected: A file named `PYTHONUNBUFFERED`

3. Check the content of the file:

```bash
kubectl exec -n todoapp <POD_NAME> -- cat /app/configs/PYTHONUNBUFFERED
```

Expected: `1`

## Validate that Secret data is mounted correctly as files

1. List files in the `/app/secrets` directory:

```bash
kubectl exec -n todoapp <POD_NAME> -- ls /app/secrets
```

Expected: A file named `SECRET_KEY`

2. Check the content of the file:

```bash
kubectl exec -n todoapp <POD_NAME> -- cat /app/secrets/SECRET_KEY
```

Expected: The decoded value of the secret

## Validate PersistentVolume mount

Check that the `/app/data` directory exists and is writable:

```bash
kubectl exec -n todoapp <POD_NAME> -- ls /app/data
```
