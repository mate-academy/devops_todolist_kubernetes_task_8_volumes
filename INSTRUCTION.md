# Validation Instructions

## 1. Validate that the application is running

Run:

```
./bootstrap.sh
```

Check the application Pods:

```
kubectl get pods -n todoapp
```

The Todo app Pods must have the status:

```
Running
```

and:

```
READY 1/1
```

To check the application itself, run:

```
kubectl port-forward -n todoapp service/todoapp-service 8080:80
```

Open in a browser:

```
http://localhost:8080
```

The Todo application should be available.

---

## 2. Validate that ConfigMap data is mounted as files in the right order

Get the name of the Todo app Pod:

```
POD=$(kubectl get pods -n todoapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}')
```

Check the ConfigMap mount:

```
kubectl exec -n todoapp $POD -- ls -la /app/configs
```

The ConfigMap data must be mounted as files inside `/app/configs`.

For the existing `app-config`, the expected file is:

```
PYTHONUNBUFFERED
```

Check its content:

```
kubectl exec -n todoapp $POD -- cat /app/configs/PYTHONUNBUFFERED
```

Expected result:

```
1
```

The ConfigMap must be mounted as read-only. Verify this with:

```
kubectl exec -n todoapp $POD -- touch /app/configs/test.txt
```

The command must fail because the filesystem is read-only.

---

## 3. Validate that Secret data is mounted as a file

Check the Secret mount:

```
kubectl exec -n todoapp $POD -- ls -la /app/secrets
```

The Secret data must be mounted as a file inside `/app/secrets`.

The expected file is:

```
SECRET_KEY
```

Verify that the file exists and is not empty:

```
kubectl exec -n todoapp $POD -- sh -c 'test -s /app/secrets/SECRET_KEY && echo "Secret mounted successfully"'
```

Expected result:

```
Secret mounted successfully
```

The Secret must be mounted as read-only. Verify this with:

```
kubectl exec -n todoapp $POD -- touch /app/secrets/test.txt
```

The command must fail because the filesystem is read-only.
