# To validate app is running 
1. Run command after execution of which all app pods should be running and ready
kubectl get pods -n <app_namespace>
2. Enable port forward to get access to the app on local machine by running command:
kubectl port-forward pod/<app-pod-name> <local-port>:<clusterIP-target-port> -n <app-namespace>
3. Open in the browser webpage http://localhost:<local-port>
# To validate that ConfigMap data is mounted as files in the right order
1. Run command:
kubectl exec -it <app-pod-name> bash
2. Run command:
ls -la /app/configs
# To validate that secret data is mounted as files in the right order
1. Run command:
kubectl exec -it <app-pod-name> bash
2. Run command:
ls -la /app/secrets