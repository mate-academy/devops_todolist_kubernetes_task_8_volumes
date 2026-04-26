To deploy all required resources to the cluster, run:

```bash
bash bootstrap.sh
```

The bootstrap.sh script contains all commands needed to deploy the project in the correct order.
It applies the namespace, PersistentVolume, PersistentVolumeClaim, ConfigMap, Secret, Deployment, Service, and HPA manifests.

Check that the app is running

Run:
```bash
kubectl get pods -n todoapp
```

Make sure the pod status is `Running`.

Open http://localhost:8080 in the browser.

 Check that ConfigMap data is mounted as files

Get the pod name:
```bash
kubectl get pods -n todoapp
```

Then verify that the ConfigMap data is mounted inside /app/configs:
```bash
kubectl exec -n todoapp <pod-name> -- ls /app/configs
```

```bash
kubectl exec -n todoapp <pod-name> -- cat /app/configs/PYTHONUNBUFFERED
```

This confirms that the ConfigMap data is mounted as files in the correct directory.


Check that Secret data is mounted as a file

Verify that the Secret data is mounted inside /app/secrets:
```bash
kubectl exec -n todoapp <pod-name> -- ls /app/secrets
```

```bash
kubectl exec -n todoapp <pod-name> -- cat /app/secrets/SECRET_KEY
```

This confirms that the Secret data is mounted as a file in the correct directory.

