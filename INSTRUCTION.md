## Testing

### 1. Running our application

To get the environment up and running, we apply all our manifests using the following script:

```bash
./bootstrap.sh
```

First, let's verify if our Volumes were successfully created:

```bash
kubectl get pv,pvc -n todoapp
```

**Expected output:**
```text
NAME                            CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                 STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
persistentvolume/pv-todoapp     1Gi        RWX            Delete           Bound    todoapp/pvc-todoapp   standard       <unset>                          14s

NAME                                    STATUS   VOLUME       CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
persistentvolumeclaim/pvc-todoapp       Bound    pv-todoapp   1Gi        RWX            standard       <unset>                 10s
```

Next, we check if our application pod is running:

```bash
kubectl get pods -n todoapp
```

**Expected output:**
```text
NAME                       READY   STATUS    RESTARTS   AGE
todoapp-77879975dc-v982s   1/1     Running   0          59s
```
> **Note:** The `NAME` string of your pod will be different.

---

### 2. Checking the ConfigMap mount

> **Note:** In the commands below, replace `<pod_name>` with your actual pod name from the previous step.

Let's check if the ConfigMap was successfully mounted to our pod:

```bash
kubectl exec -it <pod_name> -n todoapp -- ls -la /app/configs
```

**Expected output** (showing the contents of the mounted directory):
```text
/app/configs:
total 16
drwxrwxrwx 3 root root 4096 Jul 20 15:38 .
drwxr-xr-x 1 root root 4096 Jul 20 15:38 ..
drwxr-xr-x 2 root root 4096 Jul 20 15:38 ..2026_07_20_15_38_27.3334609503
lrwxrwxrwx 1 root root   32 Jul 20 15:38 ..data -> ..2026_07_20_15_38_27.3334609503
lrwxrwxrwx 1 root root   23 Jul 20 15:38 PYTHONUNBUFFERED -> ..data/PYTHONUNBUFFERED
```

We can also read the actual value from the `PYTHONUNBUFFERED` file:

```bash
kubectl exec -it <pod_name> -n todoapp -- cat /app/configs/PYTHONUNBUFFERED
```

**Expected output:**
```text
1
```

---

### 3. Checking the Secret mount

Now, let's verify if the Secret is mounted successfully:

```bash
kubectl exec -it <pod_name> -n todoapp -- ls -la /app/secrets
```

**Expected output:**
```text
/app/secrets:
total 8
drwxrwxrwt 3 root root  100 Jul 20 15:38 .
drwxr-xr-x 1 root root 4096 Jul 20 15:38 ..
drwxr-xr-x 2 root root   60 Jul 20 15:38 ..2026_07_20_15_38_27.1272246844
lrwxrwxrwx 1 root root   32 Jul 20 15:38 ..data -> ..2026_07_20_15_38_27.1272246844
lrwxrwxrwx 1 root root   17 Jul 20 15:38 SECRET_KEY -> ..data/SECRET_KEY
```

Finally, let's verify the contents of the `SECRET_KEY` file:

```bash
kubectl exec -it <pod_name> -n todoapp -- cat /app/secrets/SECRET_KEY
```

**Expected output:**
```text
@e2(yx)v&tgh3_s=0yja-i!dpebxsz^dg47x)-k&kq_3zf*9e*
```

This is our actual, **decoded** key value. 

> **How Secrets work in Kubernetes:** 
> While Kubernetes stores Secrets in Base64 format within the manifests, Kubelet automatically decodes them back to plain text when mounting them as files or environment variables inside the pod.

---

### 💡 DevOps Pro-Tip: Avoid manual pod names

To avoid copying and pasting the generated pod name every time, you can use the Deployment name directly. Kubernetes will automatically pick the first available pod for the `exec` command:

```bash
kubectl exec -it deployment/todoapp -n todoapp -- cat /app/secrets/SECRET_KEY
```