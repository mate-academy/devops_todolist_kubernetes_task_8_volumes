## How to Validate Your Deployment

### 1. Validate the App is Running

Check that the pod is running and ready:

```sh
kubectl get pods -n todoapp
kubectl get deployment -n todoapp
kubectl get svc -n todoapp
```

Port-forward to the pod and test the app endpoint:

```sh
kubectl port-forward deployment/todoapp 8080:8080 -n todoapp
curl http://localhost:8080/
```

---

### 2. Validate ConfigMap Data is Mounted as Files

Exec into the running pod:

```sh
kubectl exec -it <pod-name> -n todoapp -- /bin/sh
```

List files in the `/app/configs` directory:

```sh
ls /app/configs
```

View the contents of the ConfigMap file (example for PYTHONUNBUFFERED):

```sh
cat /app/configs/PYTHONUNBUFFERED
```

---

### 3. Validate Secret Data is Mounted as Files

List files in the `/app/secrets` directory:

```sh
ls /app/secrets
```

View the contents of the Secret file (example for SECRET_KEY):

```sh
cat /app/secrets/SECRET_KEY
```
