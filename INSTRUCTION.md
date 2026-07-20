# Preparation

Before validation, deploy all required Kubernetes resources by using the `bootstrap.sh` script.

Make the script executable:

```bash
chmod +x bootstrap.sh
```

Run the script from the root directory of the repository:

```bash
./bootstrap.sh
```

# Validation

## Verify that the application is running

Check that the application Pods are running:

```bash
kubectl get pods -n todoapp
```

Get the node IP address:

```bash
kubectl get nodes -o wide
```

Get the NodePort assigned to the application service:

```bash
kubectl get services -n todoapp
```

Open the following URL in a browser:

```text
http://<NODE_IP>:<NODE_PORT>
```

Replace `<NODE_IP>` with the node IP address and `<NODE_PORT>` with the port exposed by the NodePort Service.

## Verify that the PersistentVolumeClaim is bound

Check the PersistentVolume and PersistentVolumeClaim status:

```bash
kubectl get pv
kubectl get pvc -n todoapp
```

The PersistentVolumeClaim `pvc-data` should have the `Bound` status and should be connected to the PersistentVolume `pv-data`.

## Verify that the PersistentVolume is mounted

Get the Pod name:

```bash
kubectl get pods -n todoapp
```

Open a shell inside the Pod:

```bash
kubectl exec -it <POD_NAME> -n todoapp -- sh
```

Check that the persistent volume is mounted at `/app/data`:

```sh
ls -la /app/data
```

## Verify that ConfigMap data is mounted as files

Inside the Pod, list the files mounted from the ConfigMap:

```sh
ls -la /app/configs
```

Display the contents of the mounted ConfigMap files:

```sh
for file in /app/configs/*; do
  echo "=== $file ==="
  cat "$file"
done
```

The files should contain the data from the `app-config` ConfigMap.

## Verify that Secret data is mounted as files

Inside the Pod, list the files mounted from the Secret:

```sh
ls -la /app/secrets
```

Display the contents of the mounted Secret files:

```sh
for file in /app/secrets/*; do
  echo "=== $file ==="
  cat "$file"
done
```

The files should contain the data from the `app-secret` Secret.

Do not publish actual secret values in screenshots, logs, or the pull request description.
