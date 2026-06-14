# Validation instructions

## 1. Deploy the resources

Run the bootstrap script from the repository root:

```bash
./bootstrap.sh
```

## 2. Verify that the app is running

Check that the deployment and pod are ready:

```bash
kubectl get pods -n todoapp
kubectl get deployment -n todoapp
```

If you want to test the web app directly, port-forward the pod locally:

```bash
kubectl port-forward deploy/todoapp 8080:8080 -n todoapp
```

Then open http://127.0.0.1:8080/.

## 3. Verify the ConfigMap mount

Confirm that the ConfigMap is mounted as a file in /app/configs:

```bash
kubectl exec -n todoapp deploy/todoapp -- sh -c 'ls -1 /app/configs && echo "---" && cat /app/configs/PYTHONUNBUFFERED'
```

## 4. Verify the Secret mount

Confirm that the Secret is mounted as a file in /app/secrets:

```bash
kubectl exec -n todoapp deploy/todoapp -- sh -c 'ls -1 /app/secrets && echo "---" && cat /app/secrets/SECRET_KEY'
```
