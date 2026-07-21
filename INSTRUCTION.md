# Інструкція з перевірки томів (Volumes) та моунтів у Kubernetes

## 1. Автоматичне розгортання ресурсів
Для створення всіх необхідних ресурсів кластера (Namespace, PV, PVC, ConfigMap, Secret, Deployment, Services) виконайте скрипт:

```bash
bash bootstrap.sh

# Перевірка статусу PersistentVolume та PersistentVolumeClaim
kubectl get pv
kubectl get pvc -n todoapp

# Перевірка статусу Пода
kubectl get pods -n todoapp

#Перевірка працездатності додатку
kubectl exec -it deployment/todoapp -n todoapp -- curl http://localhost:8080/api/health

# Перегляд вмісту директорії /app/configs
kubectl exec -it deployment/todoapp -n todoapp -- ls -la /app/configs

# Перевірка вмісту конфігураційного файлу
kubectl exec -it deployment/todoapp -n todoapp -- cat /app/configs/PYTHONUNBUFFERED

# Перегляд вмісту директорії /app/secrets
kubectl exec -it deployment/todoapp -n todoapp -- ls -la /app/secrets

# Перевірка вмісту секретного файлу
kubectl exec -it deployment/todoapp -n todoapp -- cat /app/secrets/SECRET_KEY

# Перегляд вмісту директорії даних
kubectl exec -it deployment/todoapp -n todoapp -- ls -la /app/data