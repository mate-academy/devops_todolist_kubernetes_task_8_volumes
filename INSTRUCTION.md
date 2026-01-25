# Kubernetes Deployment – INSTRUCTION

## Перевірка підключення до кластера
```bash
kubectl config current-context
kubectl get nodes
```

## Застосування ресурсів (у правильному порядку)

### 1. Namespace
```bash
kubectl apply -f .infrastructure/namespace.yml
kubectl get ns
```

### 2. PersistentVolume
```bash
kubectl apply -f .infrastructure/pv.yml
kubectl get pv
```

### 3. PersistentVolumeClaim
```bash
kubectl apply -f .infrastructure/pvc.yml -n todoapp
kubectl get pvc -n todoapp
```

### 4. Secret
```bash
kubectl apply -f .infrastructure/secret.yml -n todoapp
kubectl get secret -n todoapp
```

### 5. ConfigMap
```bash
kubectl apply -f .infrastructure/confgiMap.yml -n todoapp
kubectl get configMap -n todoapp
```

### 6. Deployment
```bash
kubectl apply -f .infrastructure/deployment.yml -n todoapp
kubectl get deployments -n todoapp
kubectl get pods -n todoapp
```

### 7. Очікування запуску pod'ів (1–3 хв)
```bash
kubectl get pods -n todoapp -w
```

### 8. Service (NodePort)
```bash
kubectl apply -f .infrastructure/nodeport.yml -n todoapp
kubectl get svc -n todoapp
```

### 9. HPA (Horizontal Pod Autoscaler)
```bash
kubectl apply -f .infrastructure/hpa.yml -n todoapp
kubectl get hpa -n todoapp
```

## Перевірка стану

### Pod'и
```bash
kubectl get pods -n todoapp
kubectl describe pod <pod-name> -n todoapp
kubectl logs <pod-name> -n todoapp
```

### Persistent Volumes
**Примітка:** PV не мають namespace, PVC — мають
```bash
kubectl describe pv
kubectl describe pvc -n todoapp
```

## Короткий порядок застосування
1. Namespace (todoapp)
2. PersistentVolume
3. PersistentVolumeClaim
4. Secret
5. ConfigMap
6. Deployment
7. Wait 1–3 min
8. Service (NodePort)
9. HPA
10. Check Pods / PVC / PV

## Валідація розгортання

### 1. Перевірка, що додаток працює

```bash
# Перевірка статусу подів
kubectl get pods -n todoapp

# Перевірка, що поди в стані Running
kubectl get pods -n todoapp -o wide

# Перевірка логів поду
kubectl logs <pod-name> -n todoapp

# Перевірка доступу до додатку через Service
kubectl get svc -n todoapp
# Отримайте NodePort та перевірте доступність через браузер або curl
curl http://<node-ip>:<nodeport>/

# Перевірка health endpoints
kubectl exec <pod-name> -n todoapp -- curl http://localhost:8080/api/health
kubectl exec <pod-name> -n todoapp -- curl http://localhost:8080/api/ready
```

### 2. Перевірка монтування ConfigMap як файлів у правильному порядку

```bash
# Перевірка, що ConfigMap змонтований у /app/configs
kubectl exec <pod-name> -n todoapp -- ls -la /app/configs

# Перевірка вмісту файлів ConfigMap
kubectl exec <pod-name> -n todoapp -- cat /app/configs/PYTHONUNBUFFERED

# Перевірка, що монтування read-only
kubectl exec <pod-name> -n todoapp -- touch /app/configs/test.txt
# Ця команда повинна завершитися помилкою (read-only файлова система)

# Перевірка порядку файлів (якщо є кілька файлів)
kubectl exec <pod-name> -n todoapp -- ls -1 /app/configs
```

### 3. Перевірка монтування Secret як файлу

```bash
# Перевірка, що Secret змонтований у /app/secrets
kubectl exec <pod-name> -n todoapp -- ls -la /app/secrets

# Перевірка вмісту файлів Secret (без виведення значень)
kubectl exec <pod-name> -n todoapp -- ls -1 /app/secrets

# Перевірка, що файли Secret існують та доступні
kubectl exec <pod-name> -n todoapp -- test -f /app/secrets/SECRET_KEY && echo "Secret file exists"

# Перевірка, що монтування read-only
kubectl exec <pod-name> -n todoapp -- touch /app/secrets/test.txt
# Ця команда повинна завершитися помилкою (read-only файлова система)
```

### 4. Додаткова перевірка PersistentVolume

```bash
# Перевірка PVC
kubectl get pvc -n todoapp
kubectl describe pvc pvc-data -n todoapp

# Перевірка PV
kubectl get pv
kubectl describe pv pv-data

# Перевірка, що дані зберігаються у /app/data
kubectl exec <pod-name> -n todoapp -- ls -la /app/data
kubectl exec <pod-name> -n todoapp -- df -h /app/data
```


