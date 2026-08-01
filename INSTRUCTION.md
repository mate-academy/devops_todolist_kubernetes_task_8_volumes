# Instructions for testing the application

## Checking that the application is up and running

First, check that the application pods are running and ready:

```bash
kubectl get pods -n todoapp
```

The application pods should have the `Running` status, and all containers should be ready.

Check that the PersistentVolume has been created:

```bash
kubectl get pv
```

The PersistentVolume should have the `Bound` status.

Check that the PersistentVolumeClaim has been created:

```bash
kubectl get pvc -n todoapp
```

The PersistentVolumeClaim should also have the `Bound` status.

Forward the application port to the local machine:

```bash
kubectl port-forward deployment/todoapp 8080:8080 -n todoapp
```

Open a browser and check that the application is available at:

```text
http://localhost:8080
```

## Checking that ConfigMap data is mounted as files

First, get the application pod name:

```bash
kubectl get pods -n todoapp
```

Copy the name of one of the application pods and connect to it:

```bash
kubectl exec -it <pod-name> -n todoapp -- sh
```

Inside the pod, check that the ConfigMap data is mounted in the correct directory:

```bash
ls -la /app/configs
```

Each ConfigMap key should be represented as a separate file in the `/app/configs` directory.

Check the contents of the mounted ConfigMap file:

```bash
cat /app/configs/PYTHONUNBUFFERED
```

The command should display the value stored under the `PYTHONUNBUFFERED` key in the ConfigMap.

## Checking that Secret data is mounted as files

Inside the same pod, check that the Secret data is mounted in the correct directory:

```bash
ls -la /app/secrets
```

Each Secret key should be represented as a separate file in the `/app/secrets` directory.

Check the contents of the mounted Secret file:

```bash
cat /app/secrets/SECRET_KEY
```

The command should display the value stored under the `SECRET_KEY` key in the Secret.

Exit the pod:

```bash
exit
```