## How to validate App is running
``
     http://localhost:30007/api
``

## How to validate configMap data is mounted as files in the right order
## Secret data is mounted as a file

``
     
     kubectl exec {kubectl get pods -l app=todoapp -o jsonpath='{.items[0].metadata.name}'} -it -- sh 
     ls
     cd configs
     ls
     cat APP_ENV // Testing-volumes
     cd ..
     ls

``
