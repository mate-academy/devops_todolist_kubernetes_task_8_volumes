kubectl get storageclass
kubectl describe pvc mypvc
First you need to get pod name.
POD=$(kubectl get pods -n todoapp -o jsonpath='{.items[1].metadata.name}'))
Run in browser http://localhost:30009
Or kubectl logs  $POD.
If you see website or "[30/Jun/2026 14:51:01] "GET /api/health HTTP/1.1" 200 9" aplication is working.

How to validate: ConfigMap data is mounted as files in the right order and secret data is mounted as a file?
kubectl exec $POD -it -- sh
# ls
Dockerfile  accounts  api  configs  data  db.sqlite3  lists  manage.py  probes  requirements.txt  secrets  todolist
# cd /app/configs
# ls
PYTHONUNBUFFERED
# cat PYTHONUNBUFFERED
1# cd ..
# ls
Dockerfile  accounts  api  configs  data  db.sqlite3  lists  manage.py  probes  requirements.txt  secrets  todolist
# cd /app/secrets
# ls
SECRET_KEY
# cat SECRET_KEY       
@e2(yx)v&tgh3_s=0yja-i!dpebxsz^dg47x)-k&kq_3zf*9e*
# 
