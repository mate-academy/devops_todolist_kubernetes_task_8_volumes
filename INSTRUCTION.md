To validate App is running:
check pods

kubectl get pods

Use this to go into the pod, and check if there is ConfigMap data

kubectl exec "pod name" -it -n mateapp -- sh

To navigate use
ls
cd
or any other command 

with secret data the same