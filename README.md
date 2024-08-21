## Guideline

1. Run the `bootstrap.sh` script to deploy all resources:

bootstrap.sh

## Instructions on how to validate

1. App is running

   kubectl get pods -n todoapp

2. ConfigMap data is mounted as files in a right order

   kubectl exec -it <pod-name> -n todoapp -- ls /app/configs

3. Secret data is mounted as file

   kubectl exec -it <pod-name> -n todoapp -- ls /app/secrets
