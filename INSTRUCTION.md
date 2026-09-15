1. Run
```
bootstrap.sh
```
it will create the namespace and apply all manifests

2. Check that all pods are running
```
kubectl get pods -n todoapp
```

3. Check that the app is running

3.1. Get the node IP
```
kubectl get nodes -o wide
```

3.2. Open the app in a browser or curl it using the NodePort (30007)
```
curl http://<node-ip>:30007/api/health
```
a successful response confirms the app is running

4. Check that the ConfigMap data is mounted as files in the right order

4.1. Get the pod name
```
kubectl get pods -n todoapp
```

4.2. List the mounted config files
```
kubectl exec -n todoapp <pod-name> -- ls /app/configs
```

4.3. Print the content of the mounted config file and compare it with the ConfigMap
```
kubectl exec -n todoapp <pod-name> -- cat /app/configs/PYTHONUNBUFFERED
```

5. Check that the Secret data is mounted as a file

5.1. List the mounted secret files
```
kubectl exec -n todoapp <pod-name> -- ls /app/secrets
```

5.2. Print the content of the mounted secret file
```
kubectl exec -n todoapp <pod-name> -- cat /app/secrets/SECRET_KEY
```
