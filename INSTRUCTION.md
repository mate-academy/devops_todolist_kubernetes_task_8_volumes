# Validation Instructions

Follow these steps to validate the Kubernetes resources and that the ToDo app works as required.

## Prerequisites ✅
- kubectl configured and able to talk to your cluster
- Resources applied (use `./bootstrap.sh`) and the `todoapp` namespace exists

---

## 1) Verify the app is running 🚦
1. Apply resources (if not already applied):
```bash
chmod +x bootstrap.sh
./bootstrap.sh
```
2. Check Deployment and pods:
```bash
kubectl -n todoapp get deployment mate
kubectl -n todoapp get pods -l app=mate-app -o wide
```
3. Wait for rollout ready:
```bash
kubectl -n todoapp rollout status deployment/mate --timeout=120s
```
4. Get logs to detect runtime errors:
```bash
kubectl -n todoapp logs deployment/mate --tail=200
```
5. Quick HTTP test (inside cluster):
```bash
POD=$(kubectl -n todoapp get pods -l app=mate-app -o jsonpath='{.items[0].metadata.name}')
kubectl -n todoapp exec -it $POD -- curl -fsS -o /dev/null -w "%{http_code}\n" http://127.0.0.1:8080/
```
- Expected: `200` (or another non-5xx code); you can also port-forward and open in a browser:
```bash
kubectl -n todoapp port-forward deployment/mate 8080:8080 &
curl -v http://localhost:8080/
```

---

## 2) Validate ConfigMap is mounted as files (and in the expected order) 📁
1. List files inside `/app/configs`:
```bash
kubectl -n todoapp exec -it $POD -- ls -1 /app/configs
```
2. Confirm ordering: Kubernetes exposes files named after ConfigMap keys; to preserve order, keys should be prefixed (e.g., `01-`, `02-`). To check numeric ordering:
```bash
kubectl -n todoapp exec -it $POD -- ls -1 /app/configs | nl -ba
```
3. View content of a file:
```bash
kubectl -n todoapp exec -it $POD -- cat /app/configs/01-app.conf
```
4. Check file permissions (optional):
```bash
kubectl -n todoapp exec -it $POD -- stat -c '%a %n' /app/configs/*
```
- Expected: files exist, readable, and names reflect the intended order (numeric prefixes if ordering matters).

---

## 3) Validate Secret is mounted as a file 🔒
1. List Secrets files:
```bash
kubectl -n todoapp exec -it $POD -- ls -l /app/secrets
```
2. View secret value (stored as plaintext in the file):
```bash
kubectl -n todoapp exec -it $POD -- cat /app/secrets/SECRET_KEY
```
3. Check file permissions (should be restricted):
```bash
kubectl -n todoapp exec -it $POD -- stat -c '%a %n' /app/secrets/*
```
- Expected: the secret file exists and has restrictive perms (e.g., `400` or `440`).

---

## 4) Validate PersistentVolume mount and persistence 💾
1. Confirm PV & PVC states:
```bash
kubectl get pv,pvc
kubectl -n todoapp describe pvc todo-pvc
```
- Expected: PVC is `Bound` to the PV
2. Check mount inside the pod:
```bash
kubectl -n todoapp exec -it $POD -- ls -ld /app/data
```
3. Persistence test:
```bash
kubectl -n todoapp exec -it $POD -- sh -c "echo persisted > /app/data/healthcheck.txt && ls -l /app/data"
kubectl -n todoapp delete pod $POD
# Wait for a new pod to be ready
NEWPOD=$(kubectl -n todoapp get pods -l app=mate-app -o jsonpath='{.items[0].metadata.name}')
kubectl -n todoapp exec -it $NEWPOD -- cat /app/data/healthcheck.txt
```
- Expected: file `healthcheck.txt` still contains `persisted` after pod restart (data persisted on the PV hostPath).

---

## 5) Helpful checks & troubleshooting 💡
- Check resource existence in namespace:
```bash
kubectl -n todoapp get configmap,secret
```
- If ConfigMap files missing, ensure the ConfigMap keys are present and that you used the correct mount path.
- If HTTP returns 500, check `kubectl -n todoapp logs <pod>` for stack traces (usually missing SECRET_KEY, DB errors, or static files).
- If permission issues, review `defaultMode` in `deploy.yml` for the ConfigMap/Secret volumes.
- Verify mounts with `mount` inside the pod:
```bash
kubectl -n todoapp exec -it $POD -- mount | grep /app
```

---

## 6) Create a PR for validation (quick steps) 📝
1. Create a branch:
```bash
git checkout -b feat/k8s-volumes
```
2. Add & commit files (example):
```bash
git add pv.yml pvc.yml deploy.yml bootstrap.sh INSTRUCTION.md
git commit -m "Add PV/PVC, deployment, bootstrap and validation instructions"
```
3. Push and open PR (GitHub web UI or CLI):
```bash
git push -u origin feat/k8s-volumes
# Then open a PR on GitHub with a brief description and attach this repo for review
```

---

If any check fails, copy the exact command output and share it here and I'll help you troubleshoot the failing step.
