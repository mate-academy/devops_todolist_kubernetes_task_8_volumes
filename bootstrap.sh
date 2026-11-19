#!/usr/bin/env bash
set -euo pipefail

# Run from any directory. Manifests may be in .infrastructure/ or the repo root.
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NAMESPACE="todoapp"

find_manifest() {
  local file="$1"
  if [[ -f "$ROOT_DIR/.infrastructure/$file" ]]; then
    printf '%s\n' "$ROOT_DIR/.infrastructure/$file"
  elif [[ -f "$ROOT_DIR/$file" ]]; then
    printf '%s\n' "$ROOT_DIR/$file"
  else
    printf 'ERROR: %s not found in .infrastructure/ or repository root.\n' "$file" >&2
    exit 1
  fi
}

command -v kubectl >/dev/null 2>&1 || { echo 'ERROR: kubectl is not installed.' >&2; exit 1; }

printf 'Using Kubernetes context: %s\n' "$(kubectl config current-context)"

# 1. Create the namespace if necessary.
if ! kubectl get namespace "$NAMESPACE" >/dev/null 2>&1; then
  kubectl create namespace "$NAMESPACE"
fi

# 2. A PV is cluster-scoped. A PVC belongs to the todoapp namespace.
kubectl apply -f "$(find_manifest pv.yml)"
kubectl apply -f "$(find_manifest pvc.yml)"

# 3. Use the existing ConfigMap/Secret when available, or create them.
#    Never commit a real SECRET_KEY to the repository.
if ! kubectl get configmap app-config -n "$NAMESPACE" >/dev/null 2>&1; then
  kubectl create configmap app-config -n "$NAMESPACE" --from-literal=PYTHONUNBUFFERED=1
fi

if ! kubectl get secret app-secret -n "$NAMESPACE" >/dev/null 2>&1; then
  command -v python3 >/dev/null 2>&1 || { echo 'ERROR: python3 is required to generate a secret.' >&2; exit 1; }
  secret_key="$(python3 -c 'import secrets; print(secrets.token_urlsafe(48))')"
  kubectl create secret generic app-secret -n "$NAMESPACE" --from-literal="SECRET_KEY=$secret_key"
  unset secret_key
fi

# Verify that the existing resources contain the keys expected by the Deployment.
if ! kubectl get configmap app-config -n "$NAMESPACE" -o jsonpath='{.data.PYTHONUNBUFFERED}' | grep -q .; then
  echo 'ERROR: ConfigMap app-config must contain PYTHONUNBUFFERED.' >&2
  exit 1
fi
if ! kubectl get secret app-secret -n "$NAMESPACE" -o jsonpath='{.data.SECRET_KEY}' | grep -q .; then
  echo 'ERROR: Secret app-secret must contain SECRET_KEY.' >&2
  exit 1
fi

# 4. Deploy application after its dependencies exist.
kubectl apply -f "$(find_manifest deployment.yml)"

# Restart to refresh environment variables if the Secret/ConfigMap was updated earlier.
kubectl rollout restart deployment/todoapp -n "$NAMESPACE"
kubectl rollout status deployment/todoapp -n "$NAMESPACE" --timeout=180s

# 5. Show resources without revealing secret contents.
kubectl get pv pv-volume
kubectl get pvc pvc-volume -n "$NAMESPACE"
kubectl get pods -n "$NAMESPACE" -l app=todoapp

echo 'Deployment finished. See INSTRUCTION.md for validation steps.'
#!/bin/bash
