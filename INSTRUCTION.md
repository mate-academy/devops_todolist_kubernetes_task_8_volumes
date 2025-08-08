To validate if app is running you should use command:
kubectl get pods -n todoapp
and after this you should watch on the pods status
To check if secret and configmap is mounted in pod, you should connect to pod and use ls command
Firstly connect to pod:
kubectl exec -it -n todoapp <podname> -- sh
You can see the configs and secrets by executing:
ls 
The output would be
 kubectl exec -it -n todoapp todoapp-64665b447-bcgtz -- sh
# ls
Dockerfile  accounts  api  configs  data  db.sqlite3  lists  manage.py  probes  requirements.txt  secrets  todolist
# cd configs
# ls
PYTHONUNBUFFERED
# cd ..
# ls
Dockerfile  accounts  api  configs  data  db.sqlite3  lists  manage.py  probes  requirements.txt  secrets  todolist
# cd secrets
# ls
SECRET_KEY
# cat se
cat: se: No such file or directory
# cat SECRET_KEY
@e2(yx)v&tgh3_s=0yja-i!dpebxsz^dg47x)-k&kq_3zf*9e*