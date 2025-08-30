kubectl get ns mateapp
kubectl -n mateapp get cm,secret
kubectl get pv
kubectl -n mateapp get pvc
kubectl -n mateapp get deploy,pods -o wide
kubectl -n mateapp rollout status deploy/todoapp
# якщо у вас інша назва деплоймента: deploy/todoapp-deployment
