---
title: 13 Kubernetes Configurations You Should Know
description: This blog post describes how to set up Eightshift Boilerplate theme, and covers some of the most common issues that may occur
slug: 13-kubernetes-configurations
authors: monosense
tags: [kubernetes, cloud-computing, devops]
hide_table_of_contents: false
---

As Kubernetes continues to be the cornerstone of container orchestration, mastering its configurations and features becomes imperative for DevOps professionals. In 2024, certain Kubernetes configurations stand out for their ability to enhance automation, security, and performance in cloud-native environments. This blog post delves into 13 essential Kubernetes configurations, offering a deep dive into each, complete with use cases, benefits, and code examples.
{/* truncate */}
## Resource Requests and Limits
Understanding and correctly setting resource requests and limits is foundational in Kubernetes. It ensures that your applications have the resources they need to run optimally while preventing any single application from monopolizing cluster resources.
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: sample-app
spec:
  containers:
  - name: app-container
    image: nginx
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
```
- **Why**: This configuration is crucial for maintaining the stability and performance of both individual applications and the overall cluster. It prevents resource contention and ensures that applications are not terminated unexpectedly due to resource shortages.
- **Who**: Essential for Kubernetes administrators and developers aiming to optimize application performance and cluster resource utilization.
- **When to Use**: Apply this configuration for every workload to ensure predictable application performance and to prevent any single application from consuming disproportionate resources that could impact cluster stability.
[Link](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)

## Liveness and Readiness Probes
Liveness and readiness probes are critical for managing the lifecycle of your applications within Kubernetes. They help Kubernetes make intelligent decisions about when to restart a container (liveness) and when a container is ready to start accepting traffic (readiness).
```yaml
livenessProbe:
  httpGet:
    path: /healthz
    port: 8080
  initialDelaySeconds: 3
  periodSeconds: 3
readinessProbe:
  httpGet:
    path: /ready
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 5
```
- **Why**: They enhance the resilience and availability of your applications by ensuring Kubernetes can automatically manage the state of containers based on actual application health rather than just container runtime state.
- **Who**: Developers and operators deploying critical services that require high availability and self-healing.
- **When to Use**: Implement liveness probes for applications where uptime is critical, and readiness probes for applications that should only receive traffic when fully initialized and ready to serve requests.
[Link](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
[Guide](https://overcast.blog/using-readiness-and-liveness-probes-for-smooth-scaling-in-kubernetes-9f752735b739)

## ConfigMaps and Secrets
`ConfigMaps` and Secrets are indispensable for externalizing configuration and sensitive data from application code. ConfigMaps allow you to store non-confidential data in key-value pairs, while Secrets are intended for sensitive information.
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  config.json: |
    {
        "database": "sql",
        "timeout": "30s",
        "featureFlag": "true"
    }
---
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
type: Opaque
data:
  password: cGFzc3dvcmQ=
```

- **Why**: These configurations decouple configuration and secrets from application logic, simplifying application deployment and management across different environments while enhancing security.
- **Who**: Vital for any Kubernetes user managing applications that require configuration data or need to securely handle credentials and other sensitive information.
- **When to Use**: Use ConfigMaps for application configuration that changes between environments (development, staging, production) and Secrets for any credentials, tokens, or sensitive information.
[Link](https://kubernetes.io/docs/concepts/configuration/secret/)

## Horizontal Pod Autoscaler (HPA)
The `Horizontal Pod Autoscaler` automatically adjusts the number of pod replicas in a Deployment, ReplicaSet, or StatefulSet based on observed CPU utilization or custom metrics.
```yaml
apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  name: sample-app-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: sample-app
  minReplicas: 1
  maxReplicas: 10
  targetCPUUtilizationPercentage: 80
```
- **Why**: HPA ensures that your application can scale out to meet demand and scale in when demand decreases, optimizing resource usage and maintaining performance.
- **Who**: Administrators and DevOps professionals looking to automate scaling of applications based on real-time demand.
- **When to Use**: Ideal for applications with variable traffic, ensuring that resources are dynamically allocated to meet demand without manual intervention.
[Link](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
[Guide](https://overcast.blog/13-ways-to-optimize-kubernetes-horizontal-pod-autoscaler-bd5911683bb2)

## Network Policies
Network policies are Kubernetes resources that control the flow of traffic between pods and network endpoints, allowing you to implement microsegmentation and enhance the security of your Kubernetes applications.
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-all
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
```

- **Why**: They are crucial for securing pod communications within a Kubernetes cluster, ensuring that only authorized traffic can flow between pods or to external services.
- **Who**: Kubernetes administrators and security-focused engineers who need to enforce strict network security policies within their clusters.
- **When to Use**: Especially useful in multi-tenant environments or applications with high security requirements to prevent unauthorized access and limit potential attack vectors.
[Link](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
[Guide](#)

## Service Accounts
`Service Accounts` in Kubernetes are used to provide an identity for pods to interact with the Kubernetes API and other services within the cluster. They are crucial for managing access control and ensuring secure communication between services.
```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: my-service-account
  namespace: default
Using a Service Account in a Pod:
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
  - name: my-container
    image: my-image
  serviceAccountName: my-service-account
```
- **Why**: Service Accounts are essential for attributing API requests made from within pods to a specific identity, enabling fine-grained access control and auditing. They are also necessary for pods that require access to the Kubernetes API or other cluster services.
- **Who**: Kubernetes cluster administrators and developers who need to securely manage access to Kubernetes APIs and resources from within pods.
- **When to Use**: Use Service Accounts when deploying applications that interact with the Kubernetes API or need to authenticate to other services within the cluster, especially for automated tasks or microservices that require specific permissions.
[Link](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/)

## Ingress Controllers and Ingress Resources
Ingress controllers and resources manage external access to the services in a cluster, typically HTTP, allowing you to define rules for routing traffic to different services.
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
spec:
  rules:
  - host: www.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: example-service
            port:
              number: 80
```

- **Why**: They provide a centralized, scalable, and secure method of managing access to your Kubernetes services from the internet.
- **Who**: DevOps professionals and Kubernetes administrators managing public-facing applications.
- **When to Use**: Vital for any application that requires controlled access from outside the Kubernetes cluster, especially when managing multiple services or performing URL-based routing.
[Link](https://kubernetes.io/docs/concepts/services-networking/ingress/)

## Persistent Volumes (PV) and Persistent Volume Claims (PVC)
`Persistent Volumes (PV)` and Persistent Volume Claims (PVC) offer a method for managing storage in Kubernetes, abstracting the details of how storage is provided and how it is consumed.
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: example-pv
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  nfs:
    path: /path/to/data
    server: nfs-server.example.com
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: example-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
```

- **Why**: They are crucial for stateful applications that need to store data persistently, beyond the lifecycle of a pod.
- **Who**: Engineers working with databases, file storage, and other stateful applications within Kubernetes.
- **When to Use**: Whenever your application requires persistent data storage that is independent of pod lifecycle, ensuring data durability and availability.
[Link](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
[Guide](https://overcast.blog/mastering-persistent-volume-claims-primitive-in-kubernetes-f443e63086bc)

## Role-Based Access Control (RBAC)
`RBAC` enforces fine-grained access control policies to Kubernetes resources, using roles and role bindings to restrict permissions within the cluster.
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
  namespace: default
subjects:
- kind: User
  name: "jane"
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

- **Why**: It’s crucial for maintaining the principle of least privilege across your Kubernetes cluster, ensuring users and applications have only the permissions they need.
- **Who**: Cluster administrators and security-conscious engineers implementing secure access policies.
- **When to Use**: Implement RBAC whenever you need to secure access to Kubernetes resources, particularly in environments with multiple users or teams.
[Link](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
[Guide](https://overcast.blog/managing-role-based-access-control-rbac-in-kubernetes-a-guide-79d5ed5cbdf6)

## Custom Resource Definitions (CRD)
`CRDs` allow you to extend Kubernetes API by defining custom resources, bringing in new functionalities tailored to your needs.
```yaml
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: crontabs.stable.example.com
spec:
  group: stable.example.com
  names:
    kind: CronTab
    listKind: CronTabList
    plural: crontabs
    singular: crontab
  scope: Namespaced
  versions:
  - name: v1
    served: true
    storage: true
    schema:
      openAPIV3Schema:
        type: object
        properties:
          spec:
            type: object
            properties:
              cronSpec:
                type: string
              image:
                type: string
```

- **Why**: CRDs empower you to create and manage custom objects, integrating seamlessly with Kubernetes APIs and kubectl tooling.
- **Who**: Developers and operators looking to introduce custom operations or resources into their Kubernetes environment.
- **When to Use**: Ideal for extending Kubernetes when existing resources do not meet your application’s specific requirements.
[Link](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/)

## Taints and Tolerations
Taints and tolerations work together to ensure that pods are not scheduled onto inappropriate nodes.
```yaml
apiVersion: v1
kind: Node
metadata:
  name: node1
spec:
  taints:
  - key: "key1"
    value: "value1"
    effect: NoSchedule
```

- **Why**: They offer a powerful mechanism for controlling the placement of pods on nodes, based on factors like hardware, software, and other custom requirements.
- **Who**: Cluster administrators seeking to optimize workload placement and enforce separation concerns within multi-tenant environments.
- **When to Use**: Use when you need to prevent certain pods from being placed on specific nodes, such as dedicating nodes for specific workloads.
[Link](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)

## Affinity and Anti-affinity
`Affinity` and `anti-affinity` settings allow you to influence where pods should (or should not) be placed relative to other pods.
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: with-pod-affinity
spec:
  selector:
    matchLabels:
      app: with-pod-affinity
  template:
    metadata:
      labels:
        app: with-pod-affinity
    spec:
      affinity:
        podAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: security
                operator: In
                values:
                - S1
            topologyKey: "kubernetes.io/hostname"
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            podAffinityTerm:
              labelSelector:
                matchExpressions:
                - key: security
                  operator: In
                  values:
                  - S2
              topologyKey: "kubernetes.io/hostname"
```

- **Why**: Essential for managing pod distribution across the cluster to enhance fault tolerance, availability, or to meet other operational requirements.
- **Who**: Administrators and developers looking to fine-tune pod placement for performance optimization or regulatory compliance.
- **When to Use**: Particularly useful in high-availability setups, or when workload separation is required for security or compliance reasons.
[Link](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)
[Guide](https://overcast.blog/mastering-node-affinity-and-anti-affinity-in-kubernetes-db769af90f5c)

## Kubernetes Jobs and CronJobs
`Jobs` and `CronJobs` manage tasks that need to run once or repeatedly at specified intervals, respectively.
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: example-job
spec:
  template:
    spec:
      containers:
      - name: hello
        image: busybox
        command: ["sh", "-c", "echo Hello Kubernetes! && sleep 30"]
      restartPolicy: Never
---
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: example-cronjob
spec:
  schedule: "*/5 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: hello
            image: busybox
            command: ["sh", "-c", "echo Hello Kubernetes! && sleep 30"]
          restartPolicy: OnFailure
```
- **Why**: Jobs and CronJobs are crucial for automating tasks within Kubernetes, such as backups, maintenance operations, or batch processing.
- **Who**: Engineers automating routine tasks or running batch jobs within their Kubernetes environments.
- **When to Use**: Implement Jobs for one-off tasks or setup CronJobs for tasks that need to run on a schedule.
[Link](https://kubernetes.io/docs/concepts/workloads/controllers/job/)

## Summary
These advanced Kubernetes configurations provide a foundation for creating robust, efficient, and secure cloud-native applications. Understanding and leveraging these settings allows engineers to fully harness the power of Kubernetes, tailor deployments to specific needs, and maintain optimal operational standards.