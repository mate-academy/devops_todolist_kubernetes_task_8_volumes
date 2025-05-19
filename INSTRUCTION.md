# INSTRUCTION.md

## 🧪 Як запустити та перевірити ToDo app з об'ємами та змінними

---

## 📦 1. Застосування ресурсів

```bash
kubectl apply -f .infrastructure/namespace.yml
kubectl apply -f .infrastructure/pv.yml
kubectl apply -f .infrastructure/pvc.yml
kubectl apply -f .infrastructure/configMap.yml
kubectl apply -f .infrastructure/secret.yml
kubectl apply -f .infrastructure/clusterIp.yml
kubectl apply -f .infrastructure/nodeport.yml
kubectl apply -f .infrastructure/hpa.yml
kubectl apply -f .infrastructure/deployment.yml
або:

```bash
./bootstrap.sh
🔎 2. Перевірити, що додаток працює
```bash
kubectl get pods -n todoapp
Под повинен бути в статусі Running з 1/1.

🔐 3. Перевірити змінні середовища
```bash
kubectl exec -n todoapp -it <pod-name> -- sh
printenv | grep PYTHONUNBUFFERED
# очікується: PYTHONUNBUFFERED=1
📁 4. Перевірити маунти ConfigMap та Secret
```bash

# Перевірка конфігів:
ls /app/configs
cat /app/configs/PYTHONUNBUFFERED

# Перевірка секретів:
ls /app/secrets
cat /app/secrets/SECRET_KEY
💾 5. Перевірити маунт PVC
```bash
ls /app/data
# має бути порожнім або містити файл лічильника