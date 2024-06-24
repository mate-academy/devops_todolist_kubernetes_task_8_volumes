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
    1. How Output 'cat counter.txt' from a pod
1. Create PR with your changes and attach it for validation on a platform.


---

# SOLUTION

1. We need to install kind.exe

    for this we need to

    1) download it

    2) transfer to suitable folder

    ```
    curl.exe -Lo kind-windows-amd64.exe https://kind.sigs.k8s.io/dl/v0.23.0/kind-windows-amd64
    Move-Item .\kind-windows-amd64.exe C:\Program Files\Docker\kind\kind.exe
    ```

    3) add to windows environment variables path
        - settings -> about -> advanced -> advanced -> environment variables -> system -> path -> change -> add address with kind.exe
2. delete cluster

    ```
    kind delete cluster
    ```
3. create modified cluster (prepared by mateacademy)

    ```
    kind create cluster --config .\cluster.yml
    ```

    wait until creation is succefull
4. apply all manifests (commands described in bootstrap.sh)


# VALIDATION

1. App is running since we can access to all the features of the app on `http://localhost:30007/`
2. validation of configMap data is mounted as a file in `/app/configs/`

    * getting pods names `kubectl get pods -n todoapp -o wide`

      ```
      NAME                       READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
      todoapp-788658c587-lhwjd   1/1     Running   0          11m   10.244.1.2   kind-worker2   <none>           <none>
      todoapp-788658c587-mzmzc   1/1     Running   0          11m   10.244.2.2   kind-worker    <none>           <none>
      ```
    * accessing app pod shell `kubectl exec -it todoapp-788658c587-mzmzc -n todoapp -- sh`

      ```
      # pwd
      /app
      # ls -lat
      total 200
      drwxr-xr-x 1 root root   4096 Jun 24 00:32 ..
      drwxr-xr-x 1 root root   4096 Jun 24 00:32 .
      drwxrwxrwt 3 root root    100 Jun 24 00:32 secrets
      drwxrwxrwx 3 root root   4096 Jun 24 00:32 configs
      drwxrwxrwt 1 root root     40 Jun 24 00:29 data
      -rw-r--r-- 1 root root 151552 Mar 29 08:35 db.sqlite3
      drwxr-xr-x 1 root root   4096 Feb 10 14:13 todolist
      -rw-r--r-- 1 root root    488 Feb 10 14:02 Dockerfile
      drwxr-xr-x 3 root root   4096 Feb 10 13:26 probes
      drwxr-xr-x 1 root root   4096 Feb 10 12:38 api
      drwxr-xr-x 1 root root   4096 Feb 10 12:24 accounts
      drwxr-xr-x 1 root root   4096 Feb 10 12:24 lists
      -rw-r--r-- 1 root root     86 Feb 10 11:39 requirements.txt
      -rw-r--r-- 1 root root    251 Dec 15  2023 manage.py
      # cd configs
      # ls -lat
      total 16
      drwxr-xr-x 1 root root 4096 Jun 24 00:32 ..
      drwxrwxrwx 3 root root 4096 Jun 24 00:32 .
      drwxr-xr-x 2 root root 4096 Jun 24 00:32 ..2024_06_24_00_32_19.1508072873
      lrwxrwxrwx 1 root root   32 Jun 24 00:32 ..data -> ..2024_06_24_00_32_19.1508072873
      lrwxrwxrwx 1 root root   23 Jun 24 00:32 PYTHONUNBUFFERED -> ..data/PYTHONUNBUFFERED
      # cat PYTHONUNBUFFERED
      1# 
      ```
3. validation of secrets data is mounted as a file in `/app/secrets/`

    * getting pods names `kubectl get pods -n todoapp -o wide`

      ```
      NAME                       READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
      todoapp-788658c587-lhwjd   1/1     Running   0          11m   10.244.1.2   kind-worker2   <none>           <none>
      todoapp-788658c587-mzmzc   1/1     Running   0          11m   10.244.2.2   kind-worker    <none>           <none>
      ```
    * accessing app pod shell `kubectl exec -it todoapp-788658c587-mzmzc -n todoapp -- sh`

      ```
      # pwd
      /app
      # ls -lat
      total 200
      drwxr-xr-x 1 root root   4096 Jun 24 00:32 ..
      drwxr-xr-x 1 root root   4096 Jun 24 00:32 .
      drwxrwxrwt 3 root root    100 Jun 24 00:32 secrets
      drwxrwxrwx 3 root root   4096 Jun 24 00:32 configs
      drwxrwxrwt 1 root root     40 Jun 24 00:29 data
      -rw-r--r-- 1 root root 151552 Mar 29 08:35 db.sqlite3
      drwxr-xr-x 1 root root   4096 Feb 10 14:13 todolist
      -rw-r--r-- 1 root root    488 Feb 10 14:02 Dockerfile
      drwxr-xr-x 3 root root   4096 Feb 10 13:26 probes
      drwxr-xr-x 1 root root   4096 Feb 10 12:38 api
      drwxr-xr-x 1 root root   4096 Feb 10 12:24 accounts
      drwxr-xr-x 1 root root   4096 Feb 10 12:24 lists
      -rw-r--r-- 1 root root     86 Feb 10 11:39 requirements.txt
      -rw-r--r-- 1 root root    251 Dec 15  2023 manage.py
      # cd ./secrets
      # pwd
      /app/secrets
      # ls -lat
      total 8
      drwxr-xr-x 1 root root 4096 Jun 24 00:32 ..
      drwxrwxrwt 3 root root  100 Jun 24 00:32 .
      drwxr-xr-x 2 root root   60 Jun 24 00:32 ..2024_06_24_00_32_19.4178127434
      lrwxrwxrwx 1 root root   32 Jun 24 00:32 ..data -> ..2024_06_24_00_32_19.4178127434
      lrwxrwxrwx 1 root root   17 Jun 24 00:32 SECRET_KEY -> ..data/SECRET_KEY
      # cat SECRET_KEY
      @e2(yx)v&tgh3_s=0yja-i!dpebxsz^dg47x)-k&kq_3zf*9e*
      ```
4. How Output `cat counter.txt` from a pod

    <u>**it is impossible**</u> since there is no `counter.txt` in existance

    * getting pods names `kubectl get pods -n todoapp -o wide`

      ```
      NAME                       READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
      todoapp-788658c587-lhwjd   1/1     Running   0          11m   10.244.1.2   kind-worker2   <none>           <none>
      todoapp-788658c587-mzmzc   1/1     Running   0          11m   10.244.2.2   kind-worker    <none>           <none>
      ```
    * accessing app pod shell `kubectl exec -it todoapp-788658c587-mzmzc -n todoapp -- sh`

      ```
      # find / "counter.txt"
      ...checking_all_system_files...
      find: ‘counter.txt’: No such file or directory
      ```
