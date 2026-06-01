# 1) How to validate is app running:

**Firstly:**

    kubectl get pods -n todoapp

Find your pods and check running status and if these pods are ready, then:

    kubectl port-forward svc/todoapp-nodeport <your_port>:80 -n todoapp

# 2) How to validate ConfigMap data is mounted as files in the right order:

    kubectl exec -it <name_pod> -n todoapp -- sh

Inside this container you will have the directory configs, in this directory you will have your configuration variables 

# 3) How to validate Secret data is mounted as a file:

    kubectl exec -it <name_pod> -n todoapp -- sh

Inside this container you will have the directory secrets, in this directory you will have your secrets variables 