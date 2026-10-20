1. How to deploy all the required resources in the cluster.

    - go to the "bootstrap.sh" directory;
    - run "bootstrap.sh" in the terminal.

2. How to validate the app is running.

    - Pod's status must be "Running":

        kubectl get pods -n todoapp

    - Go to localhost:30007 in your browser.

3. How to validate ConfigMap data is mounted as files in the right order.

    - Connect to any pod in your cluster. Ensure that the /app/configs directory exist and include files with ConfigMap.yml key's filenames.

        kubectl get pods -n todoapp && kubectl exec <pod's name> -it -n todoapp -- sh && ls /app/configs

4. How to validate Secret data is mounted as files in the right order.

    - Connect to any pod in your cluster. Ensure that the /app/secrets directory exist and include files with secret.yml key's filenames.

        kubectl get pods -n todoapp && kubectl exec <pod's name> -it -n todoapp -- sh && ls /app/secrets