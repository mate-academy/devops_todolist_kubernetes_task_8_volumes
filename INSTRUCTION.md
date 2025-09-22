## Pre-requirements - run bootstrap script with command ```./bootstrap.sh```

## Validate that all resources exist:
- `kubectl get ns` - you should see todoapp namespace
- ` kubectl get configmaps -n todoapp` - you should see created config map
- ` kubectl get secrets -n todoapp` - you should see created secret
- ` kubectl get pv -n todoapp` - you should see created pv
- ` kubectl get pvc -n todoapp` - you should see created pvc
- ` kubectl get pods -n todoapp` - you should see created pods in 'Running' state
- ` kubectl get hpa -n todoapp` - you should see created hpa

## Validate secrets and config map mount:
- run `kubectl exec <pod-name> -it -- sh` to connect to pod shell
- run `cat configs/PYTHONUNBUFFERED` to see config value content
- rub `cat secrets/SECRET_KEY` to see secret content
