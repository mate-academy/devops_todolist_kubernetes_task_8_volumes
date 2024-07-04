# Django ToDo list

This is a todo list web application with basic features of most web apps, i.e., accounts/login, API, and interactive UI. To do this task, you will need:

- CSS | [Skeleton](http://getskeleton.com/)
- JS  | [jQuery](https://jquery.com/)

## Explore

Try it out by installing the requirements (the following commands work only with Python 3.8 and higher, due to Django 4):

```
pip install -r requirements.txt
```

Create a database schema:

```
python manage.py migrate
```

And then start the server (default is http://localhost:8000):

```
python manage.py runserver
```

Now you can browse the [API](http://localhost:8000/api/) or start on the [landing page](http://localhost:8000/).

## Task

Create a kubernetes manifest for a pod which will containa ToDo app container:

1. Fork this repository.
2. Create a `pv.yml` file for `PersistentVolume` resource.
3. `PersistentVolume` requirements:
    1. `PersistentVolume` persistentVolumeReclaimPolicy `Delete`
    2. `PersistentVolume` class `standard`
    3. `PersistentVolume` accessModes `ReadWriteMany`
    4. `PersistentVolume` capacity `1Gi`
    5. `PersistentVolume` should use `hostPath`
1. Create a `pvc.yml` file for `PersitentVolumeClaim` resource.
1. `PersitentVolumeClaim` requirements:
    1. `PersitentVolumeClaim` should claim a `PersistentVolume` from a pvc file.
    2. `Deployment` should use `PersistentVolume` throught the `PersitentVolumeClaim`
    3. `PersistentVolume` mount path should be `/app/data`
1. Other Requirements
    1. Mount existing configMap as file into /app/configs folder inside container. It should be a read-only mount
    2. Mount existing secret as files into /app/secrets folder inside container. It should be a read-only mount
1. `bootstrap.sh` should containe all the commands to deploy all the required resources in the cluster
1. `README.md` should have instructuions on how to validate:
    1. App is running
    1. ConfigMap data is mounted as files in a right order
    1. Secret data is mounted as file
1. Create PR with your changes and attach it for validation on a platform.

---

### To apply all manifests use:
```bash
./bootstrap.sh
```
### Validate:
  1) to ensure the app is running visit [http://localhost:30007/](http://localhost:30007/)
  2) configMap and Secret data is mounted as a file:
      - get pods name:
      ```bash
      kubectl get pods -o wide -n todoapp
      ```
      
      ```yaml
      NAME                       READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
      todoapp-7b67d7f69d-2nlxw   1/1     Running   0          26m   10.244.2.2   kind-worker2   <none>           <none>
      todoapp-7b67d7f69d-sgfvz   1/1     Running   0          26m   10.244.1.2   kind-worker    <none>           <none>
      ```
      - get access to pod shell:
      ```bash
      kubectl exec todoapp-7b67d7f69d-2nlxw -n todoapp -it -- sh
      ```
      ```bash
      ls -l
      ```
      ```yaml
      total 188
      -rw-r--r-- 1 root root    488 Feb 10 14:02 Dockerfile
      drwxr-xr-x 1 root root   4096 Feb 10 12:24 accounts
      drwxr-xr-x 1 root root   4096 Feb 10 12:38 api
      drwxrwxrwx 3 root root   4096 Jul  4 12:43 configs
      drwxrwxrwt 1 root root     40 Jul  4 11:40 data
      -rw-r--r-- 1 root root 151552 Mar 29 08:35 db.sqlite3
      drwxr-xr-x 1 root root   4096 Feb 10 12:24 lists
      -rw-r--r-- 1 root root    251 Dec 15  2023 manage.py
      drwxr-xr-x 3 root root   4096 Feb 10 13:26 probes
      -rw-r--r-- 1 root root     86 Feb 10 11:39 requirements.txt
      drwxrwxrwt 3 root root    100 Jul  4 12:43 secrets
      drwxr-xr-x 1 root root   4096 Feb 10 14:13 todolist
      ```
      ```bash
      cd configs
      ```
      ```bash
      ls -l
      ```
      ```yaml
      total 0
      lrwxrwxrwx 1 root root 23 Jul  4 12:43 PYTHONUNBUFFERED -> ..data/PYTHONUNBUFFERED
      ```
      ```bash
      cat PYTHONUNBUFFERED
      ```
      ```yaml
      1
      ```
      ```bash
      pwd
      ```
      ```yaml
      /app/configs
      ```
      ```bash
      cd ..
      ```
      ```bash
      ls -l
      ```
      ```yaml
      total 188
      -rw-r--r-- 1 root root    488 Feb 10 14:02 Dockerfile
      drwxr-xr-x 1 root root   4096 Feb 10 12:24 accounts
      drwxr-xr-x 1 root root   4096 Feb 10 12:38 api
      drwxrwxrwx 3 root root   4096 Jul  4 12:43 configs
      drwxrwxrwt 1 root root     40 Jul  4 11:40 data
      -rw-r--r-- 1 root root 151552 Mar 29 08:35 db.sqlite3
      drwxr-xr-x 1 root root   4096 Feb 10 12:24 lists
      -rw-r--r-- 1 root root    251 Dec 15  2023 manage.py
      drwxr-xr-x 3 root root   4096 Feb 10 13:26 probes
      -rw-r--r-- 1 root root     86 Feb 10 11:39 requirements.txt
      drwxrwxrwt 3 root root    100 Jul  4 12:43 secrets
      drwxr-xr-x 1 root root   4096 Feb 10 14:13 todolist
      ```
      ```bash
      cd secrets
      ```
      ```bash
      ls -l
      ```
      ```yaml
      total 0
      lrwxrwxrwx 1 root root 17 Jul  4 12:43 SECRET_KEY -> ..data/SECRET_KEY
      ```
      ```bash
      cat SECRET_KEY
      ```
      ```yaml
      @e2(yx)v&tgh3_s=0yja-i!dpebxsz^dg47x)-k&kq_3zf*9e*
      #
      ```
