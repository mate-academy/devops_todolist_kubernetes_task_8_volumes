# Django ToDo list
## Checking is app running
Run this command
```bash
kubectl get pods -n todoapp
```
All pods should be in status running
## Looking up for ConfigMap and Secret data
### ConfigMap
```bash
kubectl get pods -n todoapp
```
Copy one pod name.
Next run this command:
```bash
kubectl exec -it < paste-pod-name > -n todoapp -- sh
```
Run `ls` command inside container. Needed file should located `app/configs`
```bash
cd /app/configs
```
Use `ls` coomand inside the directory to validate the data
### Secret
```bash
kubectl get pods -n todoapp
```
Copy one pod name.
Next run this command:
```bash
kubectl exec -it < paste-pod-name > -n todoapp -- sh
```
Run `ls` command inside container. Needed file should located `app/secrets`
```bash
cd /app/secrets
```
Use `ls` coomand inside the directory to validate the data