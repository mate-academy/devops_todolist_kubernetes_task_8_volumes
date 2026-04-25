# Django ToDo list

This is a to-do list web application with the basic features of most web apps, i.e., accounts/login, API, and interactive UI. To do this task, you will need:

- CSS | [Skeleton](http://getskeleton.com/)
- JS  | [jQuery](https://jquery.com/)

## Explore

Try it out by installing the requirements (the following commands work only with Python 3.8 and higher, due to Django 4):

```sh
pip install -r requirements.txt
```

Create a database schema:

```sh
python manage.py migrate
```

And then start the server (default is <http://localhost:8000>):

```sh
python manage.py runserver
```

You can now browse the [API](http://localhost:8000/api/) or start on the [landing page](http://localhost:8000/).

## Validation

1. to validate if app is running follow the link <http://localhost:30007>

1. To validate mounted volumes inside container
    - get list of all pods

        ```sh
        kubectl get pods -n todoapp
        ```

    - connect terminal to your pod

        ```sh
        kubectl exec -it <your_pod_name> -n todoapp -- bash
        ```

    - check all files and directories inside pod

        ```sh
        ls /app/configs
        ls /app/secrets
        cat /app/configs/PYTHONUNBUFFERED
        cat /app/secrets/SECRET_KEY
        ```

    - If /app/configs/PYTHONUNBUFFERED and /app/secrets/SECRET_KEY exist and contain values, mounts are correct.
