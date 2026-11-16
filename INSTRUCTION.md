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
```bash
POD=$(kubectl get pods -n todoapp -l app=todoapp \
  -o jsonpath='{.items[0].metadata.name}')
```
# List the mounted ConfigMap files in the expected order:
# Expected ConfigMap keys in the same order as in configMap.yml
EXPECTED_FILES=$(printf '%s\n' PYTHONUNBUFFERED)
ACTUAL_FILES=$(kubectl exec -n todoapp "$POD" -- sh -c \
  'find /app/configs -maxdepth 1 -type f -printf "%f\n"')
if [ "$ACTUAL_FILES" = "$EXPECTED_FILES" ]; then
  echo "ConfigMap files are mounted in the expected order"
else
  echo "Unexpected ConfigMap file order"
  echo "Expected:"
  printf '%s\n' "$EXPECTED_FILES"
  echo "Actual:"
  printf '%s\n' "$ACTUAL_FILES"
  exit 1
fi
# The files should appear in the same order as the ConfigMap keys:
# PYTHONUNBUFFERED
# Check the value:
kubectl exec -n todoapp "$POD" -- \
cat /app/configs/PYTHONUNBUFFERED
# Expected output: 1

## Secret data is mounted as a file
The expected Secret key order is:
```text
SECRET_KEY
```
Run:
```bash
EXPECTED_FILES=$(printf '%s\n' SECRET_KEY)
ACTUAL_FILES=$(kubectl exec -n todoapp "$POD" -- sh -c \
  'find /app/secrets -maxdepth 1 -type f -printf "%f\n"')
if [ "$ACTUAL_FILES" = "$EXPECTED_FILES" ]; then
  echo "Secret files are mounted in the expected order"
else
  echo "Unexpected Secret file order"
  echo "Expected:"
  printf '%s\n' "$EXPECTED_FILES"
  echo "Actual:"
  printf '%s\n' "$ACTUAL_FILES"
  exit 1
fi
kubectl exec -n todoapp "$POD" -- \
  test -s /app/secrets/SECRET_KEY
```
The `SECRET_KEY` file should exist and should not be empty.
