RUN bootstrap.sh
go to browser: localhost:8080

kubectl get pods -n todoapp

kubectl exec -it <pod> --sh
view app/secrets
view app/configs