### Validate: App is running
```bash
kubectl port-forward svc/todoapp-service 8080:80 -n todoapp
```
Open in browser: http://localhost:8080

### Validate: ConfigMap and Secrets are mounted in right place
get one of the pod name 
```bash
kubectl get pods -n todoapp
```
use pod_name in command below for connecting to it terminal
```bash
kubectl exec -it -n todoapp "pod_name" -- sh
```
commands to see configs and secrets mounting folders
```bash
ls /configs
ls /secrets
```

