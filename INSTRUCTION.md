## To deploy application run bootstrap.sh script 

### Validating:
### 1. Port-forward service
```angular2html
kubectl port-forward -n todoapp service/todoapp-service 8001:80
```
And get http in local browser: http://localhost:8001

### 2. For validating mount volumes

1. Get one of pod's name from deployment:
```angular2html
kubectl get pods -n todoapp
```
2. Run shell inside pod(container):
```angular2html
kubectl exec [name_of_pod] -n todoapp -it -- sh
```
3. In shell try following commands:

For checking all mount fls including /app/data, /app/configs/, /app/secrets/
```angular2html
mount
```

Navigate throw fs, for example to check secrets:
```angular2html
cd /app/secrets; cat SECRET_KEY;
```