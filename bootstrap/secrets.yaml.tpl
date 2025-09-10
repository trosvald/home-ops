---
apiVersion: v1
kind: Namespace
metadata:
  name: external-secrets
---
apiVersion: v1
kind: Namespace
metadata:
  name: networking
---
apiVersion: v1
kind: Secret
metadata:
  name: onepassword-secret
  namespace: external-secrets
stringData:
  token: op://Infra/shared-1password/OP_CONNECT_TOKEN
---
apiVersion: v1
kind: Secret
metadata:
  name: monosense-dev-tls
  namespace: networking
  annotations:
    cert-manager.io/alt-names: '*.monosense.dev,monosense.dev'
    cert-manager.io/certificate-name: monosense-dev
    cert-manager.io/common-name: monosense.dev
    cert-manager.io/ip-sans: ""
    cert-manager.io/issuer-group: ""
    cert-manager.io/issuer-kind: ClusterIssuer
    cert-manager.io/issuer-name: letsencrypt-production
    cert-manager.io/uri-sans: ""
  labels:
    controller.cert-manager.io/fao: "true"
type: kubernetes.io/tls
data:
  tls.crt: op://Dev/dev-tls/tls.crt
  tls.key: op://Dev/dev-tls/tls.key
