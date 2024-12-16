## How to validate App is running
``
     http://localhost:30007
``

## How to validate configMap data is mounted as files in the right order
## Secret data is mounted as a file

``

    kubectl exec kube2py-856b5b48f5-4zq6f -it -- sh 
    ls
    cd configs
    ls
    cat APP_ENV
    cd ..
    ls
    

``