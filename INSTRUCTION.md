validate App is running:
kubectl get pods -n my-namespace

validate ConfigMap data is mounted as files in the right order:
kubectl exec -it my-app-74d6f5f8c7-k9x7b -n my-namespace -- sh
ls

validate Secret data is mounted as a file:
kubectl exec -it my-app-74d6f5f8c7-k9x7b -n my-namespace -- sh
ls
