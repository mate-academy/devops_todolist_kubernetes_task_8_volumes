### App is running

kubectl get pods -n todoapp
kubectl describe pod <pod-name> -n todoapp
kubectl logs <pod-name> -n todoapp


### ConfigMap data is mounted as files in the right order

kubectl exec -it <pod-name> -n todoapp -- /bin/sh
ls -l /app/configs
cat /app/configs/<file-name>

### Secret data is mounted as a file

ls -l /app/secrets
cat /app/secrets/<file-name>

