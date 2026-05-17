1. To validate that app is running go to:

http://localhost:30007/

2. To validate ConfigMap data is mounted as files in the right order:
  
    ````bash
    kubectl exec -it <topoapp-pod> -n todoapp -- sh
    ````
After that check `/app/configs` directory.

3. To validate Secret data is mounted as files in the right order:
  
    ````bash
    kubectl exec -it <topoapp-pod> -n todoapp -- sh
    ````
After that check `/app/secrets` directory.