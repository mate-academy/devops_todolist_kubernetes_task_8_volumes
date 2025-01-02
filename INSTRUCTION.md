## Validation Instructions

1. **App is running**:
   - Run `kubectl get pods -n todoapp` to verify that the Todo app pod is running.
   - Check the logs with `kubectl logs <pod_name> -n todoapp`.

2. **ConfigMap data is mounted as files in the right order**:
   - Run `kubectl exec -it <todoapp-pod> -n todoapp -- ls /app/configs` and verify that the config file is present.

3. **Secret data is mounted as a file**:
   - Run `kubectl exec -it <todoapp-pod> -n todoapp -- ls /app/secrets` and verify that the secret file is present.
