# Перевірити, що застосунок запущений
kubectl get pods -n mateapp
kubectl get svc -n mateapp

# Коли под у статусі Running, можна перевірити логи:
kubectl logs -n mateapp deployment/mateapp
# Або перейти за адресою:
http://<NodeIP>:<NodePort>
# (якщо у Deployment або Service налаштовано порт 8080)

# Перевірити, що ConfigMap змонтований як файли
kubectl exec -it -n mateapp $(kubectl get pod -n mateapp -l app=mateapp -o name) -- ls /app/configs
# Очікується, що файли з ConfigMap (PYTHONUNBUFFERED тощо) будуть відображені у цій теці.

# Перевірити, що Secret змонтований як файли
kubectl exec -it -n mateapp $(kubectl get pod -n mateapp -l app=mateapp -o name) -- ls /app/secrets
# Тут мають бути файли з ключами з Secret (SECRET_KEY, тощо).

# Перевірити, що PersistentVolume підключений
kubectl exec -it -n mateapp $(kubectl get pod -n mateapp -l app=mateapp -o name) -- df -h /app/data
# Має показати змонтований том розміром близько 1Gi.

# Очищення ресурсів після тесту
kubectl delete namespace mateapp
kubectl delete pv pv-data