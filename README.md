# Validation Instructions for the ToDo App Deployment

Before validating the deployment of the ToDo app on Kubernetes, you must first run the bootstrap.sh script to set up all the necessary resources in your Kubernetes cluster.

Initial Setup: Running the *bootstrap.sh* Script
Navigate to the root folder of your cloned repository and execute the bootstrap.sh script to deploy the necessary Kubernetes resources:
```bash
# Navigate to the root directory where bootstrap.sh is located
cd path/to/root/folder

# Make the script executable
chmod +x bootstrap.sh

# Run the bootstrap.sh script
./bootstrap.sh
```
This script will apply configurations for namespaces, persistent volumes, persistent volume claims, config maps, secrets, and other necessary resources.

Follow these steps to validate that the application is correctly set up and functioning as intended.

## 1. Check if the App is Running

To ensure the ToDo app is up and running, you can check the status of the pods and ensure that the service is accessible:

```bash
kubectl get pods -n todoapp
```
If the pod is running, you should see its status as 'Running'.

## 2. Validate ConfigMap Data Mounting

ConfigMaps are used to store configuration settings that can be mounted as files within the pod. To check if the ConfigMap data is correctly mounted:

Check the mounted ConfigMap:
```bash
kubectl exec -it <pod-name> -n todoapp -- ls //app/configs
```

Replace <pod-name> with the actual name of your pod.

## 3. Validate Secret Data Mounting

Secrets are used to store sensitive information, which can also be mounted as files within the pod. To confirm if the secret data is properly mounted:

Check the mounted secret:
```bash
kubectl exec -it <pod-name> -n todoapp -- ls //app/secrets
```

Again, replace <pod-name> with the name of your pod.

## 4.Output 'cat counter.txt' from a Pod

you can use the following command:

```bash
kubectl exec -it <pod-name> -n todoapp -- cat //app/data/counter.txt
```

This command will output the content of counter.txt located in the /app/data directory within your pod.