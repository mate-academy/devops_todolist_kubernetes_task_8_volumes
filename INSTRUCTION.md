kubectl config set-context --current --namespace=todoapp

kubectl get pods
check pods status running

kubectl get svc

open in brouser
http://localhost:30007
The application ToDo should open

kubectl exec <pod-name> -it -- sh
ls
cd app
ls
cd configs
ls
cat PYTHONUNBUFFERED
cd ..
cd app
ls
cd secrets
ls
cat SECRET_KEY