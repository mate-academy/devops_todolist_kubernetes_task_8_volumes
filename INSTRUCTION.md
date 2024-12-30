kubectl get pv -n todoapp
kubectl get pvc -n todoapp
kubectl get pods -o wide -n todoapp
kubectl exec -it <pod-name> -n todoapp -- sh
   ls 
   cd 
kubectl exec -it <pod-name> -n todoapp --sh
  ls
  cd configs
  cat <name>
  cd ..
  ls
  cd secrets
  cat <name>