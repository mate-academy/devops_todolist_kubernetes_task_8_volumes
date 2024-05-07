# Django ToDo list
## Before testing
1. Get into the `.infrastructure` folder and run `bootstrap.sh` script

## Testing
1. Get list with all of your pods `kubectl get pods -n mateapp`
2. Choose any pod and get into it using `kubectl exec Name -it -n mateapp -- sh`, where `Name` is
name of the pod (first column)
3. Check the instance of the pod using `ls` command. It should be present files like `configs`, `data`, `secrets` in it
4. Get into `data` directory using `cd data` command. To receive data from a pod file `counter.txt` use `cat counter.txt`