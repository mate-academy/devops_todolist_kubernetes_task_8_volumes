## Check pods

```
kubectl get pods -n todoapp
```

## Check ConfigMap data is mounted as files in the right order

```
kubectl exec 'name-pod' -it -- sh

ls

cd configs

cd ..

cd secrets

ls
```

