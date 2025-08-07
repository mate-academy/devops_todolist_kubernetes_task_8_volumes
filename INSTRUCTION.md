
# ✅ Validation Instructions for Task 8: Volumes

## 📌 1. Перевірити, що под запущено

```bash
kubectl get pods
kubectl logs todo-app
Підстав замість todo-app ім’я твого пода,

📦 2. Перевірити, що PersistentVolumeClaim підключено
bash
Копировать
Редактировать
kubectl get pvc
kubectl describe pvc todo-pvc
Має бути статус: Bound

📂 3. Перевірити, що том змонтовано до /app/data
bash
Копировать
Редактировать
kubectl exec -it todo-app-- ls /app/data
⚙️ 4. Перевірити, що ConfigMap змонтовано як файли у /app/configs
bash
Копировать
Редактировать
kubectl exec -it <pod-name> -- ls /app/configs
kubectl exec -it <pod-name> -- cat /app/configs/PYTHONUNBUFFERED
Очікуване значення: 1

🔐 5. Перевірити, що Secret змонтовано як файли у /app/secrets
bash
Копировать
Редактировать
kubectl exec -it <pod-name> -- ls /app/secrets
kubectl exec -it <pod-name> -- cat /app/secrets/SECRET_KEY
Очікуване значення: my-very-secret-key-123