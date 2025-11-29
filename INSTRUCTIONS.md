# How to deploy and validate the Todo app with Volumes, ConfigMap and Secret

## 1. Prerequisites

- Installed **Docker**
- Installed **kind**
- Installed **kubectl**
- This repository is already cloned to your machine

All commands below are executed **from the repository root**.

---

## 2. Create kind cluster and deploy all resources

### 2.1. Make `bootstrap.sh` executable

```bash
chmod +x bootstrap.sh


# Create cluster and apply manifests

# bootstrap.sh contains all commands needed to:

# create a kind cluster using cluster.yml;

# create the todoapp namespace;

# create ConfigMap and Secret;

# create PersistentVolume and PersistentVolumeClaim;

# create Deployment;

# create services (ClusterIP + NodePort) and HPA.

Run:
./bootstrap.sh

# Quick check that resources exist
kubectl get ns
kubectl get pv
kubectl get pvc -n todoapp
kubectl get deploy -n todoapp
kubectl get pods -n todoapp
kubectl get svc -n todoapp
kubectl get hpa -n todoapp

# Validate that the app is running
# Check pods status:

kubectl get pods -n todoapp

# Check services:
kubectl get svc -n todoapp

# Get node IP (for kind on local machine it is usually localhost):
kubectl get nodes -o wide

# Open the application via NodePort
curl http://localhost:<node-port>/api/health

# Validate that ConfigMap data is mounted as files
# Get the pod name:
POD=$(kubectl get pods -n todoapp -o jsonpath='{.items[0].metadata.name}')
echo $POD

# Open a shell inside the pod:
kubectl exec -it "$POD" -n todoapp -- sh

# Inside the container list config directory:
ls -R /app/configs

# Check its content:
cat /app/configs/PYTHONUNBUFFERED

# Validate that Secret data is mounted as a file
# Again use the same pod (if needed, get its name as in 3.2):
kubectl exec -it "$POD" -n todoapp -- sh

# Inside the container list secret directory:
ls -R /app/secrets

# You should see a file named SECRET_KEY.
# Check its content (it will be the decoded value of the secret):
cat /app/secrets/SECRET_KEY

# Check PV and PVC statuses:
kubectl get pv
kubectl get pvc -n todoapp

# Create a test file inside the mounted data directory:
kubectl exec -it "$POD" -n todoapp -- sh
echo "test-data" > /app/data/test.txt
ls -R /app/data
CONTROL=$(docker ps --filter name=todoapp-volumes-control-plane -q)
docker exec -it "$CONTROL" sh -c "ls -R /data/todoapp"

# Cleanup
kind delete cluster --name todoapp-volumes