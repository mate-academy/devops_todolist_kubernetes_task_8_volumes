Clone repository
git clone repository
go to folder repository

## DEPLOY
start file bootstrap
sh ./bootstrap.sh

## TESTING
kubectl config set-context --current --namespace=mateapp
kubectl get pods
kubectl describe pod <name pod>
kubectl get pv
kubectl get pvc
kubectl describe pvc pv-data
kubectl describe pvc pvc-data
kubectl exec -n mateapp <pod-name> -- ls -l /app/configs || ls -l /app/secrets
