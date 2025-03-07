After starting our clusters we should check if our storage is available
```
kubectl get pv
```
Check here if status of our volume is AVAILABLE

If it is, then execute the: 
```
kubectl get pvc -n todoapp
```

There must be pvc-data volume status "Bound"

Next step is to connect to one of the pods interactively and execute 
```
kubectl exec <container_name> -it -- sh 
```

and check folder content with 
```
ls -la
```
You should see content we mounted like secret, data and configs
