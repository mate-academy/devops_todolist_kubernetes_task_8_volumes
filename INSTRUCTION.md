# How to Validate the Application Setup

## Run the bootstrap script:

```
./bootstrap.sh
```

## Verify Resources
Ensure all resources are succesfully created using command:
```
kubectl get all -n todoapp
```
## Check status of pods:
```
kubectl get pods -n todoapp
kubectl get pv -n todoapp
kubectl get pvc -n todoapp
```

## Connect to pods
```
kubectl exec "pod name" -n todoapp -it --sh
ls /app/secrets
ls /app/configs
```
