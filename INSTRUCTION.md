# instructions on how to validate:
# App is running
Open http://localhost:30007 in your browser.
# or
kubectl port-forward service/todoapp 8080:8080 -n todoapp
Open http://localhost:8080 in your browser.

# ConfigMap data is mounted as files in the right order
# you should replace todoapp-856b5b48f5-4zq6f with your name
kubectl exec -n todoapp todoapp-856b5b48f5-4zq6f -it -- sh

cd configs
ls
# you should see PYTHONUNBUFFERED file
cat PYTHONUNBUFFERED
# you should see 1

# Secret data is mounted as a file
cd ..
cd secrets
ls
# you should see SECRET_KEY file
cat SECRET_KEY
# you should see your secret key