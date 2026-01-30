RUN bootstrap.sh
go to browser: localhost:8080

kubectl get pods -n todoapp

kubectl exec -it <pod> --sh
cd /app/secrets
cat <secret>
cd /app/configs
cat <config>