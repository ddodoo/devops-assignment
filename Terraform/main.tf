# Apply Deployment File Using Kubectl Provider

resource "kubectl_manifest" "hello-world" {
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: hello-world
  name: hello-world
spec:
  replicas: 1
  selector:
    matchLabels:
      app: hello-world
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 0
      maxSurge: 1
  template:
    metadata:
      labels:
        app: hello-world
    spec:
      containers:
      - image: ddodoo/hello-world:v2
        name: hello-world

YAML
}


resource "helm_release" "kube-prometheus-stack" {
  name       = "kube-prometheus-stack-release"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "56.6.2 "

  values = [
    "${file("values.yaml")}"
  ]
}