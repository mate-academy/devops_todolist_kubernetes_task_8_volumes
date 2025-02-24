```bash
kubectl get pods -n todoapp
```
```bash
kubectl exec -it -n todoapp <name_of_pod> -- sh
```
There must be `PYTHONUNBUFFERED` in `/app/configs`
and `SECRET_KEY` in `/app/secrets`
