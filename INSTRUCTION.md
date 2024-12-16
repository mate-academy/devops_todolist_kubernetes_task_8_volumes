## How to validate App is running
``
     http://localhost:30007/api
``

## How to validate configMap data is mounted as files in the right order
## Secret data is mounted as a file

``
     
     kubectl get pods
    kubectl exec {pod} -it -- sh 
    ls
    cd configs
    ls
    cat APP_ENV
Testing-volumes

     cd ..
     ls

``
