In order to deploy the required cluster resources:
./bootstrap.sh

In order to check whether the todoapp server pod is running:
kubectl get pods

In order to check whether the ConfigMap and Secrets volumes are mounted correctly:

kubectl exec -it <pod-name> -- /bin/sh

cd configs
ls

cd secrets
ls