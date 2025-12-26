To ensure App is running, go via web browser to: 

  http://localhost:30007/

ConfigMap data is mounted as files in the right order.

find pod name you canaccess with command below:

kubectl get pods -n todoapp

e.g. todoapp-b5b694759-6v6sl

Access that pod:

kubectl exec -n todoapp -it todoapp-b5b694759-6v6sl -- sh

check with ls -la if there are /app/data, /app/secrets and /app/config folders

go to secrets folder (as you will start within /app folder already) and ensure SECRET_KEY is there

cd secrets
ls -la
cat SECRET_KEY


go to configs folder (as you will start within /app folder already) and ensure PYTHONUNBUFFERED is there

cd ../configs
ls -la
cat PYTHONUNBUFFERED