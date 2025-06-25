# Інструкції для Kubernetes Volumes завдання

Як розгорнути

1. Запустіть команду:

./bootstrap.sh
Переконайтесь, що всі ресурси створені:

kubectl get all -n todoapp

Перевірка
1. Додаток працює:

kubectl port-forward deployment/todoapp-deployment 8080:8080 -n todoapp
curl http://localhost:8080/api/health
Очікувано: {"status": "OK"}

2. ConfigMap монтується як файл:

kubectl exec -n todoapp deploy/todoapp-deployment -- ls /app/configs
Очікувано: PYTHONUNBUFFERED


kubectl exec -n todoapp deploy/todoapp-deployment -- cat /app/configs/PYTHONUNBUFFERED
Очікувано: 1

3. Secret монтується як файл:

kubectl exec -n todoapp deploy/todoapp-deployment -- ls /app/secrets
Очікувано: SECRET_KEY

kubectl exec -n todoapp deploy/todoapp-deployment -- cat /app/secrets/SECRET_KEY
Очікувано: super-secret-key

4. Volume змонтовано:

kubectl exec -n todoapp deploy/todoapp-deployment -- touch /app/data/testfile
kubectl exec -n todoapp deploy/todoapp-deployment -- ls /app/data
Очікувано: testfile


Volume використовує hostPath /mnt/data, тому перевірити можна також на ноді.

ConfigMap та Secret монтуються лише для читання.