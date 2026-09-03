#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFEST_DIR="${SCRIPT_DIR}/.infrastructure"

kubectl apply -f "${MANIFEST_DIR}/namespace.yml"
kubectl apply -f "${MANIFEST_DIR}/pv.yml"
kubectl apply -f "${MANIFEST_DIR}/pvc.yml"
kubectl apply -f "${MANIFEST_DIR}/configMap.yml"
kubectl apply -f "${MANIFEST_DIR}/secret.yml"
kubectl apply -f "${MANIFEST_DIR}/deployment.yml"
kubectl apply -f "${MANIFEST_DIR}/clusterIp.yml"
kubectl apply -f "${MANIFEST_DIR}/nodeport.yml"
kubectl apply -f "${MANIFEST_DIR}/hpa.yml"
