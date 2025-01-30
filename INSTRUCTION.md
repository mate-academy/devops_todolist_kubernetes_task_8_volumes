## App is running (for Windows)
open "Git Bash" command line(**or other WSL console**) and run **bootstrap.sh**:
```bash
   ./bootstrap.sh
```
## To get pod-name:
```bash
 kubectl get pods -n todoapp -o wide 
 ```
## Configuration requests for ConfigMap, Secret data and Volumes mounted:
```bash
kubectl describe pv pv-data -n todoapp
kubectl describe pvc pvc-data -n todoapp
kubectl describe pod <pod-name> -n todoapp
```