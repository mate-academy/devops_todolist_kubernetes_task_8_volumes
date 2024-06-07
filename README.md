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




# ToDo App Deployment

## How to Deploy

1. Clone the repository and navigate to the directory containing the manifests.
2. Run the `bootstrap.sh` script to deploy all resources:

bootstrap.sh
    

## Validation Steps

1. **App is running**:

    Check if the pod is running:

    kubectl get pods -n todoapp
    
    You should see a pod with the status `Running`.

2. **ConfigMap data is mounted as files in a right order**:

    Exec into the running pod and list the files in the `/app/configs` directory:


    kubectl exec -it <pod-name> -n todoapp -- ls /app/configs


    Verify that the expected files are present.

3. **Secret data is mounted as file**:

    Exec into the running pod and list the files in the `/app/secrets` directory:


    kubectl exec -it <pod-name> -n todoapp -- ls /app/secrets


    Verify that the expected files are present.

4. **How Output `cat counter.txt` from a pod**:

    Exec into the running pod and display the content of `counter.txt`:


    kubectl exec -it <pod-name> -n todoapp -- cat /app/data/counter.txt
