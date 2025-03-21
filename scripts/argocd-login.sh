#!/usr/bin/env bash
#
# login to argocd, get admin pwd from kube secret
argocd login argocd.test.com --insecure --grpc-web --username admin --password $(kubectl get secrets -n argo argocd-initial-admin-secret -o json | jq -r .data.password | base64 -d)
