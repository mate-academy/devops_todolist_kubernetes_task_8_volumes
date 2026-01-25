#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

kubectl apply -f "$ROOT_DIR/.infrastructure/namespace.yml"
kubectl apply -f "$ROOT_DIR/.infrastructure/pv.yml"
kubectl apply -f "$ROOT_DIR/.infrastructure/pvc.yml"
kubectl apply -f "$ROOT_DIR/.infrastructure/configMap.yml"
kubectl apply -f "$ROOT_DIR/.infrastructure/secret.yml"
kubectl apply -f "$ROOT_DIR/.infrastructure/deployment.yml"
kubectl apply -f "$ROOT_DIR/.infrastructure/clusterIp.yml"
