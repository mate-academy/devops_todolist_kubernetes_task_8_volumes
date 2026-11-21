# Validation instructions

## Deploy the resources

From the repository root, deploy the complete stack:

```bash
./bootstrap.sh
```

Wait for the application rollout and confirm that its pod is running:

```bash
kubectl rollout status deployment/todoapp -n todoapp
kubectl get pods -n todoapp -l app=todoapp
```

The pod should show `Running` and `READY` as `1/1`. The application is exposed by
the `todoapp-nodeport` service; obtain its port with:

```bash
kubectl get service todoapp-nodeport -n todoapp
curl --fail http://localhost:30007/api/
```

The API request should return a successful response (HTTP 200).

## Validate persistent storage

Confirm that the PV and claim are bound, then check the mount inside the running
application container:

```bash
kubectl get pv todo-pv
kubectl get pvc todo-pvc -n todoapp
kubectl exec -n todoapp deployment/todoapp -- sh -c 'mount | grep " /app/data "'
```

Both PV and PVC should report `Bound`, and the last command should show the
`/app/data` mount.

## Validate ConfigMap files

The ConfigMap is projected read-only at `/app/configs`, with one file per data key.
Verify the complete, lexically ordered set of expected `key=value` entries and
that every projected file is read-only:

```bash
kubectl exec -n todoapp deployment/todoapp -- sh -c '
  expected="PYTHONUNBUFFERED=1"
  actual="$(for file in $(find /app/configs -maxdepth 1 -type f -printf "%f\\n" | LC_ALL=C sort); do
    test ! -w "/app/configs/$file" || exit 1
    printf "%s=" "$file"
    cat "/app/configs/$file"
    printf "\\n"
  done)"
  test "$actual" = "$expected"
'
```

This verifies that the only projected entry, in lexical order, is
`PYTHONUNBUFFERED=1` and that the file is not writable by the container user.

## Validate Secret files

The Secret is projected read-only at `/app/secrets`. Confirm its file exists and
matches the Secret value without printing the secret itself:

```bash
kubectl exec -n todoapp deployment/todoapp -- test -f /app/secrets/SECRET_KEY
kubectl exec -n todoapp deployment/todoapp -- sh -c 'test ! -w /app/secrets/SECRET_KEY'
kubectl get secret app-secret -n todoapp -o jsonpath='{.data.SECRET_KEY}' \
  | base64 --decode \
  | kubectl exec -i -n todoapp deployment/todoapp -- cmp -s - /app/secrets/SECRET_KEY
```

All commands should exit successfully. The final comparison streams the decoded
Secret value to `cmp`, so neither value is printed.
