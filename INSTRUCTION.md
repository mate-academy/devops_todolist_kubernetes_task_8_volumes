## Check pods

```
kubectl get pods -n todoapp -o wide
```

## Check ConfigMap data is mounted as files in the right order

```
kubectl exec -it <name-pod> -n todoapp-- sh
cd /app/configs
ls
cd app/secrets
ls
```
