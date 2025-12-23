
# Інструкція з перевірки роботи застосунку TodoApp у Kubernetes

Підготовка

1. Ім'я namespace: todoapp (якщо ви змінювали — використовуйте своє).
2. Ім'я застосунку / мітки: app=todoapp.

1) Перевірка — застосунок запущений

Кроки:

- Переглянути namespace, pod та статус:

```
kubectl get namespaces
kubectl get pods -n todoapp
kubectl get svc -n todoapp
```

Очікуємо: Pod у статусі "Running" і наявний відповідний Service (NodePort/ClusterIP).

- Якщо Pod не запускається, перегляньте логи і опис:

```
kubectl describe pod -n todoapp <pod-name>
kubectl logs -n todoapp <pod-name> -c todoapp
```

(Примітка: замініть <pod-name> на ім'я Pod з виводу kubectl get pods.)

2) Перевірка — ConfigMap змонтований як файли і вміст відповідає (та перевірка порядку ключів)

Передумова: ConfigMap називається `app-config`.

A. Переглянути вміст ConfigMap у кластері (порядок ключів у YAML):

```
kubectl get configmap app-config -n todoapp -o yaml
```

У результаті ви побачите секцію `data:` з переліком ключів і їхнім вмістом, наприклад:

- PYTHONUNBUFFERED: "1"
- bootstrap.sh: |-
    #!/bin/bash
    ...

B. Знайти ім'я Pod і зайти в контейнер:

1) Отримати ім'я Pod (скопіюйте ім'я вручну):

```
kubectl get pods -n todoapp
```

2) Виконати команду в Pod (замініть <pod-name>):

```
kubectl exec -n todoapp -it <pod-name> -- /bin/sh -c "ls -la /app/configs"
```

Очікуємо побачити файли, що відповідають ключам ConfigMap (наприклад: `PYTHONUNBUFFERED` і `bootstrap.sh`).

C. Перевірити вміст файлів і відповідність ключам ConfigMap:

- Kubernetes змонтує кожен ключ ConfigMap в окремий файл.Щоб перглянути вміст у правильному порядку, виконайте команди `cat` для кожного файлу окремо в тому ж порядку, що й у ConfigMap, наприклад:

```
kubectl exec -n todoapp -it <pod-name> -- /bin/sh -c "cat /app/configs/PYTHONUNBUFFERED"
kubectl exec -n todoapp -it <pod-name> -- /bin/sh -c "cat /app/configs/bootstrap.sh"
```

Додатково: перевірити, що монтовання є read-only:

```
# Спроба запису має завершитися помилкою (очікувано: read-only file system або відмова в доступі)
kubectl exec -n todoapp -it <pod-name> -- /bin/sh -c "sh -c 'echo test > /app/configs/bootstrap.sh'"
```

Очікуємо повідомлення про помилку (permission denied / read-only file system).

3) Перевірка — Secret змонтований як файл

Передумова: Secret змонтований в volume з ім'ям `app-secrets`. Шлях: `/app/secrets`.

A. Переглянути вміст каталогу секретів у Pod:

```
kubectl exec -n todoapp -it <pod-name> -- /bin/sh -c "ls -la /app/secrets"
```

B. Переглянути конкретний файл секрету (приклад: SECRET_KEY):

```
kubectl exec -n todoapp -it <pod-name> -- /bin/sh -c "cat /app/secrets/SECRET_KEY"
```

Повинно відобразитися значення секрету. Kubernetes декодує base64 і у файлі буде чистий текст.

C. Перевірити, що файли секретів доступні лише для читання (спроба запису має зазнати невдачі):

```
kubectl exec -n todoapp -it <pod-name> -- /bin/sh -c "sh -c 'echo x > /app/secrets/SECRET_KEY'"
```

Очікуємо відмову в записі (read-only file system / permission denied).

Поради для усунення неполадок:

- Якщо Pod не запускається, дивіться `kubectl describe pod` і `kubectl logs` для контейнера.
- Переконайтеся, що namespace `todoapp` справді створено і що всі об'єкти застосовані в нього (`-n todoapp`).
- Якщо в маніфестах імена Secret або ConfigMap відрізняються, перевірте відповідність імен у `Deployment` і у визначеннях `Secret`/`ConfigMap`.

Готово