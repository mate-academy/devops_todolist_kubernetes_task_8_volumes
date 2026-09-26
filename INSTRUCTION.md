To run the app run:
```
./bootstrap.sh
```

To validate if app is running check localhost:30007 or 127.0.0.1:3007

To validate that ConfigMap and Secrets are mounted as a file:
```
kubectl get pods -n todoapp -o wide

kubectl exec -it {name_of_app_pod} -- sh

# inside the pod
```
ls -la /app/configs # To check if configs exist as file
ls -la /app/secrets # To check if secrets exist as file
```
