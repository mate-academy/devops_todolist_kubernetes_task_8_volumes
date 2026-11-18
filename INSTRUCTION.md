# Validation instructions

Deploy everything first:

```bash
bash bootstrap.sh
```

Pick one pod for the checks below:

```bash
POD=$(kubectl get pods -n todoapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}')
```

## 1. App is running

```bash
kubectl get pods -n todoapp            # STATUS Running, READY 1/1
kubectl get pv pv-data                 # STATUS Bound
kubectl get pvc -n todoapp             # pvc-data Bound
kubectl get svc -n todoapp
```

Open the app (Minikube): `minikube service todoapp-nodeport -n todoapp`
or `http://<node-ip>:30007`. The health endpoint should answer 200:

```bash
kubectl exec -n todoapp $POD -- curl -s -o /dev/null -w "%{http_code}\n" localhost:8080/api/health
```

## 2. ConfigMap data is mounted as files

Each key of the `app-config` ConfigMap becomes one file in `/app/configs`.
Both the ConfigMap keys and the mounted files are listed in alphabetical
order, so comparing the two lists checks that every expected file is present
and in the right order.

1. Expected files (keys defined in the ConfigMap, in order):

```bash
kubectl get configmap app-config -n todoapp \
  -o go-template='{{range $k, $v := .data}}{{$k}}{{"\n"}}{{end}}'
# PYTHONUNBUFFERED
```

2. Files actually mounted in the container, in order:

```bash
kubectl exec -n todoapp $POD -- ls -1 /app/configs
# PYTHONUNBUFFERED
```

3. Automatic comparison (no output means the files match and the order is the same):

```bash
diff \
  <(kubectl get configmap app-config -n todoapp -o go-template='{{range $k, $v := .data}}{{$k}}{{"\n"}}{{end}}') \
  <(kubectl exec -n todoapp $POD -- ls -1 /app/configs) \
  && echo "ConfigMap files match, order OK"
```

4. Content of every mounted file:

```bash
kubectl exec -n todoapp $POD -- sh -c 'for f in /app/configs/*; do echo "== $f"; cat "$f"; echo; done'
# == /app/configs/PYTHONUNBUFFERED
# 1
```

Read-only check (must fail with "Read-only file system"):

```bash
kubectl exec -n todoapp $POD -- touch /app/configs/test
```

## 3. Secret data is mounted as a file

```bash
kubectl exec -n todoapp $POD -- ls -l /app/secrets
kubectl exec -n todoapp $POD -- cat /app/secrets/SECRET_KEY
kubectl exec -n todoapp $POD -- touch /app/secrets/test   # must fail (read-only)
```

## 4. Persistent volume (optional)

```bash
kubectl exec -n todoapp $POD -- sh -c 'echo ok > /app/data/test.txt'
kubectl delete pod -n todoapp $POD
# after the new pod is Running:
NEW=$(kubectl get pods -n todoapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}')
kubectl exec -n todoapp $NEW -- cat /app/data/test.txt     # prints: ok
```
