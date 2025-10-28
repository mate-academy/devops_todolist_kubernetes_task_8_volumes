Validate that the app is running:
kubectl get pods -n todoapp


Expected output:

NAME                        READY   STATUS    RESTARTS   AGE
todoapp-6b7f8c4f6d-lj5z2    1/1     Running   0          2m


You can also check the application logs:

kubectl logs -n todoapp <pod_name>


If the logs show that the app started successfully and no errors are visible - it’s running correctly.



Validate that ConfigMap data is mounted as files

Open a shell inside the running pod:

kubectl exec -it -n todoapp <pod_name> -- sh


Check the mounted directory:

ls -l /app/configs


You should see all files defined in your ConfigMap.

View the content of any ConfigMap file:

cat /app/configs/<file_name>


Ensure it matches what you defined in your configMap.yml.

Confirm it’s mounted as read-only:

touch /app/configs/test.txt


You should see:

Read-only file system



Validate that Secret data is mounted as files

Inside the pod, list the mounted secrets:

ls -l /app/secrets




View the contents (Kubernetes automatically decodes base64 values):

cat /app/secrets/password


Check that it’s read-only:

touch /app/secrets/test.txt


You should see the same Read-only file system error.

