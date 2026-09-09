# Validation Instructions

Follow these steps to validate that the Django ToDo application is running and that the volumes (ConfigMap and Secrets) are mounted correctly.

## 1. Validate the App is Running
Check the status of the Pods to ensure the application is running and the readiness/liveness probes have passed:

bash
kubectl get pods -n todoapp


*Expected result: The pod status should be `Running` and the `READY` column should show `1/1`.*

## 2. Validate ConfigMap Data is Mounted as Files
Execute a shell inside the running container to verify the ConfigMap volume mount:

bash
# Get the exact pod name from the previous step
kubectl exec -it <pod-name> -n todoapp -- /bin/sh

# Check the contents and permissions of the configs directory
ls -l /app/configs


*Expected result: You should see the files corresponding to your ConfigMap keys. The output of `ls -l` will confirm that the files are mounted correctly.*

## 3. Validate Secret Data is Mounted as a File
While still inside the container (or by running another `exec` command), verify the Secret volume mount:

bash
# Check the contents and permissions of the secrets directory
ls -l /app/secrets


*Expected result: You should see the files corresponding to your Secret keys. The files must be present and mounted correctly as read-only.*

To exit the container's shell, simply type:
bash
exit