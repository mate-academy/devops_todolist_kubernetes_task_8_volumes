
## Validation Instructions

### 1. Validate that the application is running

Run:

```bash
kubectl get pods
```

The application Pod should be in the **Running** state.
To check logs:

```bash
kubectl logs <app-pod-name>
```

You should see normal startup logs without errors.

---

### 2. Validate that ConfigMap data is mounted as files in the correct order

First, open a shell inside the running Pod:

```bash
kubectl exec -it <app-pod-name> -- sh
```

Then check the mounted directory:

```bash
ls -la /app/configs
```

You should see files corresponding to all keys from the ConfigMap, and their alphabetical order is the same as the order defined in the ConfigMap manifest.
To inspect file contents:

```bash
cat /app/configs/<file-name>
```

---

### 3. Validate that Secret data is mounted as a file

Inside the same Pod, check the secrets directory:

```bash
ls -la /app/secrets
```

You should see one file per key from the Secret.
To verify the content is present and base64-decoded properly:

```bash
cat /app/secrets/<secret-file>
```

The data should be readable and match the expected values (not base64-encoded).

