# Verification

## Application

Check that the application Pod is running:

    kubectl get pods -n todoapp

## ConfigMap

Get the application Pod name:

    kubectl get pods -n todoapp

Open a shell inside the application Container:

    kubectl exec -it <pod-name> -n todoapp -- /bin/sh

Check that the ConfigMap files are mounted:

    ls -la /app/configs

## Secret

From the same Container shell, check that the Secret files are mounted:

    ls -la /app/secrets