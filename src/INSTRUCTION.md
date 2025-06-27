# Інструкції з валідації ToDo App на Kubernetes

Ці інструкції допоможуть вам перевірити успішність розгортання Django ToDo List програми на Kubernetes.

## 1. Попередні умови

Переконайтеся, що у вас встановлено:
- `kubectl`
- Доступ до Kubernetes кластера (Minikube, Docker Desktop Kubernetes, або будь-який інший кластер)

## 2. Розгортання програми

1.  **Форкніть репозиторій** з вихідним кодом ToDo List програми.
2.  **Створіть Docker образ** вашої програми. Використовуйте наданий `Dockerfile`. Наприклад:
    ```bash
    docker build -t leoleiden/todo-app:latest .
    ```
    (Замініть `your-docker-registry` на ім'я вашого реєстру Docker, наприклад, leoleiden, або залиште просто `todo-app:latest` якщо ви будете використовувати Minikube з `eval $(minikube docker-env)`).
3.  **Завантажте Docker образ** до вашого реєстру (якщо ви не використовуєте локальний реєстр Minikube):
    ```bash
    docker push leoleiden/todo-app:latest
    ```
4.  **Створіть файли Kubernetes Manifests** (`pv.yml`, `pvc.yml`, `configmap.yml`, `secret.yml`, `deployment.yml`, `service.yml`) з вмістом, наданим у завданні. Переконайтеся, що `image` у `deployment.yml` відповідає назві вашого Docker образу.
Для виконання вашого завдання по Kubernetes, я підготував необхідні файли конфігурації та покрокові інструкції.

1. Створення файлів Kubernetes Manifests та скриптів
Нижче наведено вміст файлів, які потрібно створити:

* pv.yml (PersistentVolume)
Цей файл описує PersistentVolume, який буде використовувати hostPath для збереження даних.
```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: todo-app-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Delete
  storageClassName: standard
  hostPath:
    path: "/mnt/data/todo-app" # Переконайтеся, що ця папка існує на вашому вузлі Kubernetes
```
* pvc.yml (PersistentVolumeClaim)
Цей файл описує PersistentVolumeClaim, який буде запитувати PersistentVolume.

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: todo-app-pvc
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Gi
  storageClassName: standard
configmap.yml (ConfigMap)
```
* Цей файл створює ConfigMap для конфігураційних файлів. Я додав приклад конфігурації для демонстрації.

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: todo-app-config
data:
  config1.txt: |
    # Це приклад конфігураційного файлу 1
    APP_DEBUG=true
    APP_ENV=development
  config2.yaml: |
    # Це приклад конфігураційного файлу 2
    database:
      type: sqlite
      name: todo_db
```
6.  **Надайте дозволи виконуваному файлу `bootstrap.sh`**:
    ```bash
    chmod +x bootstrap.sh
    ```
7.  **Виконайте скрипт розгортання**:
    ```bash
    ./bootstrap.sh
    ```
    Цей скрипт створить усі необхідні ресурси в вашому Kubernetes кластері.

## 3. Валідація роботи програми

### 3.1. Перевірка статусу Pod'ів та Service'ів

1.  **Перевірте статус Pod'ів**:
    ```bash
    kubectl get pods -l app=todo-app
    ```
    Ви повинні побачити один Pod зі статусом `Running`.
2.  **Перевірте статус Service'ів**:
    ```bash
    kubectl get service todo-app-service
    ```
    Зверніть увагу на `EXTERNAL-IP` (якщо використовується LoadBalancer) або `PORT(S)` (якщо NodePort). Для Minikube, ви можете отримати URL за допомогою:
    ```bash
    minikube service todo-app-service --url
    ```

### 3.2. Доступ до програми

Відкрийте вказаний `EXTERNAL-IP` або URL (для Minikube) у вашому веб-браузері. Ви повинні побачити інтерфейс Django ToDo List програми. Спробуйте створити нове завдання або обліковий запис.

### 3.3. Валідація монтування ConfigMap та Secret

1.  **Знайдіть ім'я вашого Pod'а**:
    ```bash
    kubectl get pods -l app=todo-app -o jsonpath='{.items[0].metadata.name}'
    ```
    Скопіюйте ім'я Pod'а.
2.  **Підключіться до Pod'а і перевірте ConfigMap**:
    ```bash
    POD_NAME=$(kubectl get pods -l app=todo-app -o jsonpath='{.items[0].metadata.name}')
    kubectl exec -it $POD_NAME -- ls /app/configs
    ```
    Ви повинні побачити `config1.txt` та `config2.yaml`.
    Перевірте вміст файлів:
    ```bash
    kubectl exec -it $POD_NAME -- cat /app/configs/config1.txt
    kubectl exec -it $POD_NAME -- cat /app/configs/config2.yaml
    ```
    Вміст повинен відповідати тому, що ви визначили у `configmap.yml`.
3.  **Підключіться до Pod'а і перевірте Secret**:
    ```bash
    POD_NAME=$(kubectl get pods -l app=todo-app -o jsonpath='{.items[0].metadata.name}')
    kubectl exec -it $POD_NAME -- ls /app/secrets
    ```
    Ви повинні побачити `secret_key.txt` та `db_password.txt`.
    Перевірте вміст файлів (зверніть увагу, Secret'и монтуються як файли з їх розкодованим вмістом):
    ```bash
    kubectl exec -it $POD_NAME -- cat /app/secrets/secret_key.txt
    kubectl exec -it $POD_NAME -- cat /app/secrets/db_password.txt
    ```
    Вміст повинен бути розкодованим значенням з `secret.yml`.

Ці кроки допоможуть вам підтвердити, що програма працює, а ConfigMap та Secret'и були правильно змонтовані.