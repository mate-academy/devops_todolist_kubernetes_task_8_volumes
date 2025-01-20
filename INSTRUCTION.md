## Інструкції для перевірки розгортання додатку ToDo

### 1. Перевірка, чи працює додаток

1. Виконайте команду, щоб перевірити стан поду:  
   ```bash
   kubectl get pods -n todoapp
   ```
   Под із додатком повинен мати статус `Running`.  

2. Перевірте, чи працює контейнер, за допомогою команди:  
   ```bash
   kubectl port-forward -n todoapp deployment/todoapp 8080:8080
   ```
   Після цього відкрийте у браузері [http://localhost:8080](http://localhost:8080). Ви повинні побачити головну сторінку додатку ToDo.  

3. Щоб перевірити доступність API, скористайтеся:  
   ```bash
   curl http://localhost:8080/api/health
   ```
   У відповідь має прийти `{"status": "healthy"}`.

---

### 2. Перевірка, чи дані з ConfigMap змонтовані як файли

1. Виконайте команду, щоб увійти в под:  
   ```bash
   kubectl exec -it -n todoapp $(kubectl get pods -n todoapp -l app=todoapp -o jsonpath="{.items[0].metadata.name}") -- /bin/bash
   ```

2. Перейдіть у папку `/app/configs`:  
   ```bash
   cd /app/configs
   ```

3. Перевірте, чи існує файл із даними з `ConfigMap`:  
   ```bash
   cat PYTHONUNBUFFERED
   ```
   У файлі має бути значення `1`.

---

### 3. Перевірка, чи дані з секретів змонтовані як файли

1. Залишаючись у поді, перейдіть у папку `/app/secrets`:  
   ```bash
   cd /app/secrets
   ```

2. Перевірте наявність файлу `SECRET_KEY`:  
   ```bash
   ls
   ```

3. Виведіть вміст файлу `SECRET_KEY` та перевірте, чи ключ відповідає значенню з `secret.yml`:  
   ```bash
   cat SECRET_KEY
   ```

---

### 4. Команди для видалення розгортання

Якщо потрібно видалити всі ресурси, виконайте наступні команди:  
```bash
kubectl delete namespace todoapp
```