# instructions on how to validate:
# App is running
cd /YourProjectDirectory/
bash bootstrap.sh
kubectl get pods -n todoapp
# All Pods should have the Running status.
Open http://localhost:30007 in your browser.
# or
kubectl port-forward service/todoapp 8080:8080 -n todoapp
Open http://localhost:8080 in your browser.

# ConfigMap data is mounted as files in the right order
# Get the Pod name:
POD=$(kubectl get pods -n todoapp -l app=todoapp \
  -o jsonpath='{.items[0].metadata.name}')

# List the mounted ConfigMap files in the expected order:
kubectl exec -n todoapp "$POD" -- sh -c \
  'find /app/configs -maxdepth 1 -type f -printf "%f\n" | sort'
# The files should appear in the same order as the ConfigMap keys:
# PYTHONUNBUFFERED
# Check the value:
kubectl exec -n todoapp "$POD" -- \
  cat /app/configs/PYTHONUNBUFFERED
# Expected output: 1

# Secret data is mounted as a file
kubectl exec -n todoapp "$POD" -- sh -c \
  'find /app/secrets -maxdepth 1 -type f -printf "%f\n" | sort'
# The files should appear in the same order as the secret.yml keys:
# SECRET_KEY
# Check the value:
kubectl exec -n todoapp "$POD" -- \
  cat /app/secrets/SECRET_KEY
# Expected output: your_secret_key