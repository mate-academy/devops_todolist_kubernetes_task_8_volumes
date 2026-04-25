# Deployment Validation Instructions

Follow these steps to ensure that the ToDo application and its associated resources are correctly deployed and configured in the Kubernetes cluster.

---

## 1. Validate the Application Status

To confirm that the application is running and ready to handle traffic:

* **Check Pod Status:**
    Run the following command to ensure the pod is in the `Running` state and all containers are `Ready`:
    ```bash
    kubectl get pods -n todoapp
    ```
    *Validation:* The `STATUS` column should show `Running` and the `READY` column should show `1/1`.

* **Access the UI:**
    Open your web browser and navigate to the application via the NodePort:
    ```
    http://localhost:30007
    ```
    *Validation:* The ToDo list interface should load without errors.

---

## 2. Validate ConfigMap Mounts

The application is configured to mount ConfigMap data as files in the `/app/configs` directory.

* **Verify Files in Container:**
    List the contents of the config directory inside the running pod:
    ```bash
    kubectl exec -n todoapp <pod-name> -- ls -l /app/configs
    ```
    *Validation:* You should see a file named `PYTHONUNBUFFERED`.

* **Verify Content:**
    Check the content of the mounted file:
    ```bash
    kubectl exec -n todoapp <pod-name> -- cat /app/configs/PYTHONUNBUFFERED
    ```
    *Validation:* The output should match the value defined in your `configMap.yml` (e.g., `1`).

---

## 3. Validate Secret Mounts

Secrets are sensitive data mounted as files in the `/app/secrets` directory.

* **Verify File Existence:**
    List the contents of the secrets directory:
    ```bash
    kubectl exec -n todoapp <pod-name> -- ls -l /app/secrets
    ```
    *Validation:* You should see a file named `SECRET_KEY`.

* **Verify Secret Content:**
    Read the content of the mounted secret file:
    ```bash
    kubectl exec -n todoapp <pod-name> -- cat /app/secrets/SECRET_KEY
    ```
    *Validation:* The output should display the decrypted (plain text) string of your secret key, confirming Kubernetes successfully decoded the base64 data during the mounting process.
