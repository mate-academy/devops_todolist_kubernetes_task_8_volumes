# Task 8: Volumes

## 1. Deploy everything

Run the bootstrap script from the repository root:

```
bash bootstrap.sh
```

It applies, in order: Namespace, PersistentVolume, PersistentVolumeClaim, ConfigMap, Secret, Deployment, Services and HPA.

> On Windows (Git Bash) put `MSYS_NO_PATHCONV=1` before every `kubectl exec` command below. Without it Git Bash rewrites paths like `/app/configs` into Windows paths.

## 2. Validate

### App is running

```
kubectl get pods,pvc,pv -n todoapp
```

Expected: the pods are `1/1 Running`, the PVC `todoapp-pvc` and the PV `todoapp-pv` are `Bound`.

### ConfigMap data is mounted as files (read-only)

```
MSYS_NO_PATHCONV=1 kubectl exec deployment/todoapp -n todoapp -- ls /app/configs
MSYS_NO_PATHCONV=1 kubectl exec deployment/todoapp -n todoapp -- cat /app/configs/PYTHONUNBUFFERED
```

Expected: the file `PYTHONUNBUFFERED` exists and contains `1`.

Check that the mounted files match the ConfigMap keys. Every key of the ConfigMap becomes one file, so the list of files must be exactly the list of keys:

```
kubectl get configmap app-config -n todoapp -o jsonpath='{.data}'
MSYS_NO_PATHCONV=1 kubectl exec deployment/todoapp -n todoapp -- ls -1 /app/configs
```

Expected: the ConfigMap has one key, `{"PYTHONUNBUFFERED":"1"}`, and the folder `/app/configs` contains exactly one file with the same name, `PYTHONUNBUFFERED`. If more keys are added to the ConfigMap, `ls -1` prints their files in alphabetical order, one per line.

The mount is read-only, writing must fail:

```
MSYS_NO_PATHCONV=1 kubectl exec deployment/todoapp -n todoapp -- touch /app/configs/test.txt
```

Expected: `Read-only file system`.

### Secret data is mounted as a file (read-only)

```
MSYS_NO_PATHCONV=1 kubectl exec deployment/todoapp -n todoapp -- ls /app/secrets
MSYS_NO_PATHCONV=1 kubectl exec deployment/todoapp -n todoapp -- wc -c /app/secrets/SECRET_KEY
```

Expected: the file `SECRET_KEY` exists and is not empty. Do not print the secret itself.

### Volume is mounted

```
MSYS_NO_PATHCONV=1 kubectl exec deployment/todoapp -n todoapp -- ls /app/data
```

Expected: the folder `/app/data` exists (it is backed by `todoapp-pvc`).