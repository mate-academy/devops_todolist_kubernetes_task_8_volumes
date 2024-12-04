# Django ToDo list

This is a to-do list web application with the basic features of most web apps, i.e., accounts/login, API, and interactive UI. To do this task, you will need:

- CSS | [Skeleton](http://getskeleton.com/)
- JS | [jQuery](https://jquery.com/)

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

You can now browse the [API](http://localhost:8000/api/) or start on the [landing page](http://localhost:8000/).

## Task

Create a Kubernetes manifest for a pod that will contain a ToDo app container:

1. Fork this repository.
2. Create a `pv.yml` file for the `PersistentVolume` resource.
3. `PersistentVolume` requirements:
   1. `PersistentVolume` persistentVolumeReclaimPolicy `Delete`
   2. `PersistentVolume` class `standard`
   3. `PersistentVolume` accessModes `ReadWriteMany`
   4. `PersistentVolume` capacity `1Gi`
   5. `PersistentVolume` should use `hostPath`
4. Create a `pvc.yml` file for `PersitentVolumeClaim` resource.
5. `PersitentVolumeClaim` requirements:
   1. `PersitentVolumeClaim` should claim a `PersistentVolume` from a pvc file.
   2. `Deployment` should use `PersistentVolume` throught the `PersitentVolumeClaim`
   3. `PersistentVolume` mount path should be `/app/data`
6. Other Requirements
   1. Mount existing configMap as file into /app/configs folder inside container. It should be a read-only mount
   2. Mount existing secret as files into /app/secrets folder inside container. It should be a read-only mount
7. `bootstrap.sh` should containe all the commands to deploy all the required resources in the cluster
8. `README.md` should have instructuions on how to validate:
   1. App is running
   1. ConfigMap data is mounted as files in a right order
   1. Secret data is mounted as file
9. Create PR with your changes and attach it for validation on a platform.

# Run the bootstrap script:

./bootstrap.sh

# Verify Resources: Ensure all resources are successfully created:

kubectl get all -n todoapp

# Status pods:

kubectl get pods -n todoapp
kubectl get pv
kubectl get pvc -n todoapp

# Connect pods:

kubectl exec "pode_name" -n todoapp -it -- sh
ls /app/secrets
ls /app/configs
