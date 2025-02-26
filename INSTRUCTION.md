```bash
 kubectl get pods -n todoapp
```
```bash
 kubectl exec -it -n todoapp busybox -- sh
```
There must be `PYTHONUNBUFFERED` in `/app/configs`
and `SECRET_KEY` in `/app/secrets`