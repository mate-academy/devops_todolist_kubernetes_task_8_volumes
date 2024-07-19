# Deployment Guide
1. **Create cluster**
    ```sh
    kind create cluster --config cluster.yml
    ```

2. **Apply all manifests**
    ```sh
    ./bootstrap.sh
    ```

## Verification

1. **Check Pods**
    ```sh
    kubectl get pods -n todoapp
    ```

2. **Check Logs**
    ```sh
    kubectl logs <name_of_pod> -n todoapp
    ```

3. **Check browser**
    ```sh
    http://localhost:30007
    ```

4. **Connect to running pod shell**
    ```sh
    kubectl exec <one of running pod name> -it -n todoapp -- sh
    ```

5. **Check data in specific files**
    ```sh
    cat configs/PYTHONUNBUFFERED
    cat secrets/SECRET_KEY
    ```