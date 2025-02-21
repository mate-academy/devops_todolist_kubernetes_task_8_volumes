Steps to validate that everything works
1. Check if the app is runnig: kubectl get pods -n todoapp
2. Check if PVC is correctly bound to PV: 
    - kubectl get pv
    - kubectl get pvc -n todoapp
3. Validate ConfigMap is mounted as file in /app/configs: kubectl exec todoapp-dbd4c988b-2jt5s -it -n todoapp -- ls -l /app/configs
4. Validate Secret is mounted as file in /app/secrets: kubectl exec todoapp-dbd4c988b-2jt5s -it -n todoapp -- ls -l /app/secrets
