# ToDo App Storage & Volumes Deployment

This guide covers the deployment of the ToDo application with Persistent Volumes, ConfigMaps, and Secrets mounted as files.

## 1. Deployment

We have created a helper script to apply all manifests in the correct order (Namespace -> PVC -> Configs -> App).

Run the following command to deploy everything:

```
chmod +x bootstrap.sh
./bootstrap.sh
```
Alternatively, you can apply manifests manually:


# 2. Validation
Follow these steps to verify that the application is running and volumes are mounted correctly.

### Step 1: Validate App Status
Ensure that the new pods are up and running.

```
kubectl get pods -n mateapp
```
Expected Output: You should see pods with status Running and READY 1/1.

### Step 2: Validate ConfigMap Mount
Check if the ConfigMap data is mounted as a file inside the container at /app/configs.

Get the name of a running pod from the previous step.

Run the following command (replace <pod-name> with your actual pod name):

```
kubectl exec -it <pod-name> -n mateapp -- ls -l /app/configs
```
Expected Output: You should see a file named PYTHONUNBUFFERED.

```P
total 0
lrwxrwxrwx 1 root root .. data
lrwxrwxrwx 1 root root .. PYTHONUNBUFFERED -> ..data/PYTHONUNBUFFERED
```
### Step 3: Validate Secret Mount
Check if the Secret data is mounted as a file inside the container at /app/secrets.

```
kubectl exec -it <pod-name> -n mateapp -- ls -l /app/secrets
```
Expected Output: You should see a file named SECRET_KEY.

### Step 4: Validate Persistent Storage
Verify that the /app/data directory is writable and backed by the Persistent Volume.

```
# Write a test file
kubectl exec -it <pod-name> -n mateapp -- sh -c "echo 'Storage Works' > /app/data/test.txt"

# Read the test file
kubectl exec -it <pod-name> -n mateapp -- cat /app/data/test.txt
```
Expected Output: Storage Works