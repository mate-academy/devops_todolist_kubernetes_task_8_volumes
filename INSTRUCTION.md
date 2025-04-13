# How to Validate the Deployment
This guide will help you validate that:
- The application is running.
- ConfigMap data is correctly mounted as files.
- Secret data is correctly mounted as files.
- PersistentVolume is created and used properly.
## 1. Ensure All Resources Are Deployed
Run the `bootstrap.sh` script to deploy all necessary manifests

`./bootstrap.sh`
## 2. Verify Application Is Running
Check the Pods

`kubectl get pods`
Check the status. It should be running :)
## 3. Check PVC and PV status
Run the following commands
```
kubectl get pv
kubectl get pvc
```
Ensure that PV and PVC is bounded
## 4. Verify Volume Mounts in Pod
Exec into a randomly generated pod 

`kubectl exec -it <name-pod> -- sh`

Run `ls` to ensure that pod have the following folders `configs` and `secrets`