# Validation instructions

Run the commands below from the repository root after starting the cluster and running `./bootstrap.sh`.

## Verify the app is running

Check that the deployment is available and its pods are ready:

```bash
kubectl -n todoapp rollout status deployment/todoapp
kubectl -n todoapp get pods -l app=todoapp
```

For a request through the NodePort, use the port exposed by the cluster configuration:

```bash
curl http://localhost:30007/
```

## Verify ConfigMap files and order

Find a ready ToDo app pod and list the mounted ConfigMap files in filename order:

```bash
POD=$(kubectl -n todoapp get pods -l app=todoapp -o jsonpath='{.items[0].metadata.name}')
kubectl -n todoapp exec "$POD" -- find /app/configs -maxdepth 1 -type f -printf '%f\n' | sort
```

The expected output is:

```text
PYTHONUNBUFFERED
```

Confirm that the mounted file contains the ConfigMap value:

```bash
kubectl -n todoapp exec "$POD" -- cat /app/configs/PYTHONUNBUFFERED
```

The expected output is `1`.

## Verify Secret file

Confirm that the Secret is mounted as a file and contains a non-empty value:

```bash
kubectl -n todoapp exec "$POD" -- sh -c 'test -s /app/secrets/SECRET_KEY && echo "SECRET_KEY is mounted"'
```

The command should print `SECRET_KEY is mounted`. Do not print the secret value during validation.