# Validation instructions for Kubernetes ToDo app deployment

## 1. App is running
- Check that the ToDo app pod is running:
  ```sh
  kubectl get pods
  ```
- Port-forward the service (if needed) and open the app in your browser:
  ```sh
  kubectl port-forward <pod-name> 8000:8000
  ```
  Then visit http://localhost:8000
- Alternatively, check logs to confirm the app has started:
  ```sh
  kubectl logs <pod-name>
  ```

## 2. ConfigMap data is mounted as files in the right order
- Identify the pod name:
  ```sh
  kubectl get pods
  ```
- Exec into the running pod:
  ```sh
  kubectl exec -it <pod-name> -- /bin/sh
  ```
- List files in the `/app/configs` directory:
  ```sh
  ls -l /app/configs
  ```
- Check the contents of the mounted files to ensure they match the ConfigMap data and are in the correct order (if order is relevant):
  ```sh
  cat /app/configs/<config-file>
  ```

## 3. Secret data is mounted as a file
- While inside the pod, list files in the `/app/secrets` directory:
  ```sh
  ls -l /app/secrets
  ```
- Check the contents of the secret files to ensure they match the expected secret data:
  ```sh
  cat /app/secrets/<secret-file>
  ```
- Ensure the permissions are read-only:
  ```sh
  ls -l /app/secrets
  ```
  Files should not be writable by the app user
