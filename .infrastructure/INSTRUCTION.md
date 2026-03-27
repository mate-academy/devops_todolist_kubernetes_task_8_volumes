To see pod IP and pod name use command:

    kubectl get pods -n todoapp

To map ports use command:

        kubectl port-forward pods/<pod_name> 8080:8080 -n todoapp

To check if app is running use command:

    curl localhost:8080

To go insede of pod use command:

    kubectl exec -it <pod_name> -- sh -n todoapp

To check config files use commands:

    cd /app/configs

    cat  PYTHONUNBUFFERED

To check secrets files use commands:

    cd /app/secrets

    cat SECRET_KEY