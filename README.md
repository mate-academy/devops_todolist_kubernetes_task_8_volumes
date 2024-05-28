1. To deploy all the resources, execute the `bootstrap.sh` script:
  
```sh 
./bootstrap.sh
```
2. Check the status of the pods to ensure the application is running:

```sh
kubectl get pods -n todoapp
```
3. Validate ConfigMap Data and Secret is Mounted as Files:

```sh
kubectl exec -it <todoapp-pod-name> -n todoapp -- ls /app/configs
kubectl exec -it <todoapp-pod-name> -n todoapp -- ls /app/secrets
```
4.Validate counter.txt Output:

```sh
kubectl exec -it <todoapp-pod-name> -n todoapp -- cat /app/data/counter.txt
```