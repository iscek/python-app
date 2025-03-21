#!/usr/bin/env bash
# Deploy a self hosted github runner into our local kube cluster
#
# ref
# https://github.com/actions/actions-runner-controller/blob/master/docs/quickstart.md
#

helm repo add actions-runner-controller https://actions-runner-controller.github.io/actions-runner-controller

helm upgrade --install --namespace actions-runner-system --create-namespace\
  --set=authSecret.create=true\
  --set=authSecret.github_token="ghp_X-replace-with-your-tokenXU"\
  --wait actions-runner-controller actions-runner-controller/actions-runner-controller

cat << EOF | kubectl apply -n actions-runner-system -f -
apiVersion: actions.summerwind.dev/v1alpha1
kind: RunnerDeployment
metadata:
  name: self-hosted-github-runner
spec:
  replicas: 1
  template:
    spec:
      repository: iscek/python-app
EOF
