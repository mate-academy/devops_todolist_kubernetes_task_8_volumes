## deploy application:
To deploy application run `./deploy_all.sh`

# to check if volumes are mounted
1. Get pod name by `kubectl get pods`
2. Connect to pod by `kubectl exec -it {pod_name} -n todoapp -- sh`
3. check if /secrets and /configs folders aren't empty.