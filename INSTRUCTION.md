http://localhost:30008/

kubectl exec $(kubectl get pod -l app=todoapp -n todoapp -o jsonpath='{.items[0].metadata.name}') -n todoapp -it -- sh
touch /app/data/testfile
ls -l /app/data
ls -1 /app/configs
ls -l /app/secrets