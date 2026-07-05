1. To validate that the app is running, you can use the following command to check the status of the pods:

```
kubectl get pods -n todoapp
kubectl get svc -n todoapp
```

2. To validate that the ConfigMap data is mounted as files in the right order, you can use the following command to check the contents of the `/app/configs` directory inside the pod:

```
kubectl exec -it <pod-name> -n todoapp -- ls /app/configs
kubectl exec -it <pod-name> -n todoapp -- cat /app/configs/PYTHONUNBUFFERED
```

3. To validate that the Secret data is mounted as a file, you can use the following command to check the contents of the `/app/secrets` directory inside the pod:

```
kubectl exec -it <pod-name> -n todoapp -- ls /app/secrets
kubectl exec -it <pod-name> -n todoapp -- cat /app/secrets/SECRET_KEY
```