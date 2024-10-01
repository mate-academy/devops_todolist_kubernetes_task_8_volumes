# Deploy the Resources

kubectl apply -f pv.yml      
kubectl apply -f pvc.yml     
kubectl apply -f configmap.yml  
kubectl apply -f secret.yml     
kubectl apply -f deployment.yml  

## Validate the App is Running

kubectl get pods -n todoapp

```
kubectl describe pod <pod-name> -n todoapp | grep "readiness probe"
```

kubectl port-forward svc/todoapp-service 8080:80 -n todoapp

```
Then, access the app in your browser via http://localhost:8080.
```

## Validate data is Mounted as Files

```
kubectl exec -it <pod-name> -n todoapp -- /bin/sh
```
Check if the ConfigMap data is mounted to the /app/configs directory:
ls /app/configs
```
ls /app/secrets
```
cat /app/secrets/SECRET_KEY
```
