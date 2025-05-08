1. Check if the application is running
Запусти команду, щоб переконатися, що под працює:

```bash
kubectl get pods -n todoapp
```  

Ти повинен побачити статус Running для поду. Наприклад:

```sql
NAME                               READY   STATUS    RESTARTS   AGE
todoapp-deploy-6d5f789b79-k9x4g    1/1     Running   0          30s
```
Можна додатково перевірити логи:

```bash
kubectl logs -n todoapp deployment/todoapp-deploy
```  

2. Check that ConfigMap is mounted as a file in /app/configs
Зайди в под:

```bash
kubectl exec -n todoapp -it $(kubectl get pods -n todoapp -l app=todoapp -o jsonpath="{.items[0].metadata.name}") -- /bin/sh
```  

Перевір наявність файлів у /app/configs:

```sh
ls /app/configs
```
Має з’явитись файл `PYTHONUNBUFFERED`.

Перевір вміст:

```sh
cat /app/configs/PYTHONUNBUFFERED
```
Очікуване значення:

```
1
```  

3. Check that Secret is mounted as a file in /app/secrets
У тому ж поді перевір файли в директорії:

```sh
ls /app/secrets
```
Має з’явитись файл `SECRET_KEY`.  

Перевір вміст:

```sh
cat /app/secrets/SECRET_KEY
```
Очікується значення (в залежності від того, що ти заенкодував у Base64):

```text
very_secret_string
```
