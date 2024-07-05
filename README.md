1. If you need you could create new cluster and/or namespace by running

```
kind create cluster --config cluster.yml
kubectl create ns todoapp
```

2. To deploying all the required resources in the cluster run command

```
sh bootstrap.sh
```

3. Now you can enjoy fantastic todo application on http://localhost:30007/ or http://127.0.0.1:30007

4. For checking successfully mounted Secret and ConfigMap get one of running pod name from pods list

```
kubectl get pods -o wide -n todoapp
```

5. Connect to running pod shell and check for data in specific files

```
kubectl exec <one of running pod name> -it -n todoapp -- sh
cat configs/PYTHONUNBUFFERED
cat secrets/SECRET_KEY
```
