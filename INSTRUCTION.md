# Kubernetes PersistentVolume and PersistentVolumeClaims

## Prerequisites
* Namespace `mateapp`

### Step 1: Apply all manifests to the mateapp namespace:

```bash
# Deploy ConfigMap
kubectl apply -f .infrastructure/configMap.yml

# Deploy Secrets
kubectl apply -f .infrastructure/secret.yml

# Deploy Persistent Volume
kubectl apply -f .infrastructure/pv.yml

# Deploy Persistent Volume Claim
kubectl apply -f .infrastructure/pvc.yml

# Deploy todoapp application
kubectl apply -f .infrastructure/deployment.yml
```

### Step 2: Confirm all resources are running in mateapp namespace:

```bash
# Check ConfigMap
kubectl get configmap -n mateapp

# Check Secrets
kubectl get secrets -n mateapp

# Check Persistent Volume
kubectl get pv

# Check Persistent Volume Claim
kubectl get pvc -n mateapp

# Check Deployment
kubectl get deployment -n mateapp
```

### Step 3: Verify and validate the deployment works in mateapp namespace:

```bash
# Validate deployment (application) is running
kubectl port-forward deployment/todoapp 8083:8080 -n mateapp
```

To make sure todoapp is working use this link: http://localhost:8083/.

```bash
# Connect to the termilal for the pod of our application (todpapp)
kubectl exec <pod-name> -n mateapp -it -- sh
```

Execute commands to make sure that ConfigMap and Secret data are mounted as files:

```bash
# ls
Dockerfile  accounts  api  configs  data  db.sqlite3  lists  manage.py  probes  requirements.txt  secrets  todolist
# cd configs
# ls
PYTHONUNBUFFERED
# cat PYTHONUNBUFFERED
1# cd ..
# ls
Dockerfile  accounts  api  configs  data  db.sqlite3  lists  manage.py  probes  requirements.txt  secrets  todolist
# cd secrets
# ls
SECRET_KEY
# cat SECRET_KEY
@e2(yx)v&tgh3_s=0yja-i!dpebxsz^dg47x)-k&kq_3zf*9e*
# exit
```

Or we can validate programmatically as:

```bash
# Get the pod name programmatically
POD_NAME=$(kubectl get pods -n mateapp -l app=todoapp -o jsonpath='{.items[0].metadata.name}')

# Verify ConfigMap mount
kubectl exec -n mateapp $POD_NAME -- cat /app/configs/PYTHONUNBUFFERED

# Verify Secret mount
kubectl exec -n mateapp $POD_NAME -- cat /app/secrets/SECRET_KEY

# Verify Data volume mount
kubectl exec -n mateapp $POD_NAME -- df -h /app/data
```