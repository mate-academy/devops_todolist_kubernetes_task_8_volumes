# ToDo App — Persistent Storage, ConfigMap & Secret Volumes Instructions

## Prerequisites

- A running Kubernetes cluster
- `kubectl` installed and configured

## 1. Deploy all resources

Run the bootstrap script, which applies all required manifests in the
correct order:

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

This creates, in order: the `todoapp` namespace, the Secret, the ConfigMap,
the ClusterIP and NodePort services, the PersistentVolume and
PersistentVolumeClaim, the Deployment, and the HorizontalPodAutoscaler.

## 2. Validate that the app is running

Check that the pods are up and running:

```bash
kubectl get pods -n todoapp
```

All pods should show status `Running`. Check the Deployment and PVC status:

```bash
kubectl get deployment -n todoapp
kubectl get pvc -n todoapp
```

The PVC should show status `Bound`.

Access the app to confirm it responds correctly, either via `port-forward`:

```bash
kubectl port-forward -n todoapp service/todoapp-clusterip-svc 8000:80
```

then open http://localhost:8000 in your browser, or via the NodePort
service (see the NodePort assigned by `kubectl get svc -n todoapp`).

## 3. Validate that the ConfigMap is mounted as a file

Open a shell inside a running pod:

```bash
kubectl exec -it -n todoapp <pod-name> -- sh
```

(Replace `<pod-name>` with an actual pod name from `kubectl get pods -n todoapp`.)

List the contents of the mounted ConfigMap folder and check that the file
order matches the keys defined in `configMap.yml`:

```sh
ls -la /app/configs
cat /app/configs/<config-key>
```

Confirm the mount is read-only by trying to write to it (this should fail):

```sh
touch /app/configs/test.txt
```

You should see a `Read-only file system` error.

## 4. Validate that the Secret is mounted as a file

While still inside the pod shell, list the contents of the mounted Secret
folder:

```sh
ls -la /app/secrets
cat /app/secrets/SECRET_KEY
```

Confirm the mount is read-only the same way:

```sh
touch /app/secrets/test.txt
```

You should see a `Read-only file system` error.

Exit the pod shell:

```sh
exit
```

## Cleaning up

```bash
kubectl delete -f .infrastructure/hpa.yml
kubectl delete -f .infrastructure/deployment.yml
kubectl delete -f .infrastructure/pvc.yml
kubectl delete -f .infrastructure/pv.yml
kubectl delete -f .infrastructure/nodeport.yml
kubectl delete -f .infrastructure/clusterip.yml
kubectl delete -f .infrastructure/configMap.yml
kubectl delete -f .infrastructure/secrets.yml
kubectl delete -f .infrastructure/namespace.yml
```