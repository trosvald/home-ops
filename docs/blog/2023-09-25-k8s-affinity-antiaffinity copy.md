---
title: Node Affinity and Anti-Affinity
description: This blog post describes how to set up Eightshift Boilerplate theme, and covers some of the most common issues that may occur
slug: kubernetes-node-affinity
authors: monosense
tags: [kubernetes, cloud-computing, devops]
hide_table_of_contents: false
---
Kubernetes, a powerful container orchestration system, offers a range of features to ensure that pods are scheduled on nodes in a manner that respects various constraints and preferences. Among these features, node affinity and anti-affinity stand out as essential tools for fine-tuning pod placement according to specific requirements. This guide delves into the concepts of node affinity and anti-affinity, demonstrating how to effectively use them to control pod scheduling within a Kubernetes cluster.
{/* truncate */}
## Understanding Node Affinity
Node affinity in Kubernetes is a set of rules used to specify preferences that affect how pods are placed on nodes. It allows you to constrain which nodes your pod is eligible to be scheduled on, based on labels on nodes and if those labels match the rules.

## Types of Node Affinity
- `RequiredDuringSchedulingIgnoredDuringExecution`: Pods will only be placed on nodes that match the specified rules. If no matching nodes are available, the pods won’t be scheduled.

- `PreferredDuringSchedulingIgnoredDuringExecution`: Specifies preferences that the scheduler will attempt to enforce but will not guarantee.

## Use Cases for Node Affinity in Kubernetes
Node affinity is a core feature of Kubernetes scheduling, allowing you to specify rules that guide the placement of pods onto nodes within the cluster. This feature is invaluable for optimizing application performance, ensuring compliance with regulatory requirements, and managing resource costs efficiently. Let’s delve into a broader range of use cases for node affinity, highlighting its versatility and providing examples to illustrate its application in real-world scenarios.

### Ensuring Compliance with Data Sovereignty Laws
In an era where data sovereignty and privacy are paramount, companies must adhere to laws that require data to be stored and processed within specific geographical boundaries. Node affinity can ensure that pods handling sensitive data are scheduled on nodes located in compliant regions.

:::tip Example
Ensuring compliance with the General Data Protection Regulation (GDPR) in Europe:
:::
```yaml
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: country
          operator: In
          values:
          - Germany
          - France
```

### Optimizing Network Latency for Distributed Systems
In distributed systems, especially those spanning multiple data centers or cloud regions, network latency can significantly impact application performance. Node affinity allows you to co-locate interdependent services in the same region or availability zone to minimize latency.

:::tip Example
Reducing latency between a frontend application and its caching layer:
:::
```yaml
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: az
          operator: In
          values:
          - us-east-1a
```

### Allocating Resources for High Performance Computing (HPC)
High-performance computing workloads, such as scientific simulations or financial modeling, require significant computational resources, often provided by specialized hardware like GPUs or high-memory nodes. Node affinity ensures that these resource-intensive applications are scheduled on appropriately equipped nodes.

:::tip Example
Scheduling a machine learning model training pod on a GPU-enabled node:
:::
```yaml
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: gpu
          operator: In
          values:
          - "true"
```

### Handling Workloads with Specific Storage Requirements
Certain applications may have specific storage requirements, such as high I/O throughput or large storage capacity, necessitating scheduling on nodes with SSDs or high-capacity disks.

:::tip Example
Scheduling a database pod requiring high disk throughput on an SSD-equipped node
:::
```yaml
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: disktype
          operator: In
          values:
          - ssd
```

### Supporting Multi-Tenancy and Resource Isolation
In multi-tenant Kubernetes clusters, where multiple teams or projects share the same cluster, node affinity can isolate workloads to dedicated nodes, preventing contention and ensuring predictable performance.

:::tip Example
Isolating team-specific workloads to designated nodes
:::
```yaml
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: team
          operator: In
          values:
          - teamA
```

## Implementing Node Affinity in Kubernetes
Node affinity in Kubernetes is a powerful feature that allows you to specify rules for how pods should be placed on nodes based on labels. This capability ensures that pods are scheduled on nodes that meet specific criteria, enhancing performance, reliability, and compliance with business or technical requirements. This tutorial provides a deep dive into implementing node affinity, covering essential concepts, practical steps, and providing examples for a better understanding.

### Prerequisites
- A Kubernetes cluster
- The `kubectl` command-line tool, configured to communicate with your cluster

### Label Your Nodes
Before defining node affinity rules, ensure your nodes are labeled according to the criteria you want to use for pod placement. Here’s how to label a node with `disktype=ssd` :

```bash
kubectl label nodes <node-name> disktype=ssd
```

### Define Node Affinity in Your Pod Specification
Let’s define a pod that should only be scheduled on nodes labeled with `disktype=ssd`.

Create a file named `ssd-pod.yaml` with the following content:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: ssd-pod
spec:
  containers:
  - name: nginx
    image: nginx
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: disktype
            operator: In
            values:
            - ssd
```
This configuration specifies that the pod should be scheduled on a node where the `disktype` label equals `ssd`.

### Deploy the Pod
Apply the configuration to your cluster:
```bash
kubectl apply -f ssd-pod.yaml
```

### Verify the Pod Placement
After deployment, check that the pod is running on a node with the `disktype=ssd` label:
```bash
kubectl get pods -o wide
```
Look for the **NODE** column in the output to verify that the `ssd-pod` is scheduled on the correct node.

## Advanced Node Affinity Use Cases
### Scheduling Pods Based on Multiple Labels
You can specify multiple labels for more granular control over pod placement. For instance, to schedule a pod on a node that has both `disktype=ssd` and `region=us-east`, modify the `nodeSelectorTerms` like so:
```yaml
nodeSelectorTerms:
- matchExpressions:
  - key: disktype
    operator: In
    values:
    - ssd
  - key: region
    operator: In
    values:
    - us-east
```
### Using Preferred Node Affinity
To preferentially schedule a pod on nodes with SSDs but fall back to other nodes if necessary, use `preferredDuringSchedulingIgnoredDuringExecution` :
```yaml
affinity:
  nodeAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
    - weight: 100
      preference:
        matchExpressions:
        - key: disktype
          operator: In
          values:
          - ssd
```
The `weight` assigns a preference level to the rule, with a higher weight indicating a stronger preference.

## Best Practices
1. **Comprehensive Labeling**: Ensure nodes are appropriately labeled to facilitate precise pod scheduling.
2. **Balance Affinity and Resource Requirements**: While node affinity can optimize pod placement, also consider pods’ resource requests and limits for balanced scheduling.
3. **Continuous Monitoring**: Regularly monitor your pods’ placement and performance to adjust affinity rules as needed.

## Understanding Node Anti-affinity
Node anti-affinity is used to specify rules that prevent the scheduling of pods in the same or different nodes. It is particularly useful in high-availability deployments where spreading pods across different nodes or zones can reduce the risk of a single point of failure.

### Use Cases for Node Anti-affinity
1. **Spreading Pods Across Nodes**: Ensuring that instances of an application are spread across multiple nodes for high availability.
2. **Separating Workloads**: Keeping certain pods from being co-located on the same node for performance or security reasons.

Node anti-affinity in Kubernetes is a critical strategy for deploying applications that require high availability, load distribution, and fault tolerance. By ensuring that certain pods do not co-locate on the same node, you can enhance the resilience and efficiency of your applications. This tutorial explores how to effectively implement node anti-affinity with practical examples and best practices.

### Key Concepts
1. `requiredDuringSchedulingIgnoredDuringExecution`: Ensures that the pod will not be scheduled onto a node if the anti-affinity rule is violated. If no node satisfies the condition, the pod remains unscheduled.
2. `preferredDuringSchedulingIgnoredDuringExecution`: The scheduler tries to avoid placing pods where the anti-affinity rule would be violated, but it’s not guaranteed.

### Scenario: Enhancing High Availability for Web Servers
Suppose you have a set of web server pods that you want to distribute across different nodes to ensure high availability. If one node fails, not all instances of your web server go down.

**Prerequisites**

Before you start, ensure you have:

- A Kubernetes cluster running.
- The `kubectl` command-line tool configured to communicate with your cluster.

1. **Define Pod Labels**

First, ensure your web server pods are labeled correctly. Here’s an example deployment that includes labels for our web server pods:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webserver-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: webserver
  template:
    metadata:
      labels:
        app: webserver
    spec:
      containers:
      - name: nginx
        image: nginx
```

This deployment creates three replicas of a web server pod, each labeled with `app: webserver`.

2. **Implement Node Anti-affinity**

To distribute these web server pods across different nodes, modify the deployment to include a node anti-affinity rule:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webserver-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: webserver
  template:
    metadata:
      labels:
        app: webserver
    spec:
      containers:
      - name: nginx
        image: nginx
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: app
                operator: In
                values:
                - webserver
            topologyKey: "kubernetes.io/hostname"
```

In this configuration, the `podAntiAffinity` rule prevents the scheduler from placing two pods with the label `app: webserver` on the same node, ensuring that your web servers are spread across different nodes.

3. **Apply the Deployment**

Apply the deployment to your cluster using `kubectl`:
```bash
kubectl apply -f webserver-deployment.yaml
```

4. **Verify Pod Distribution**

After deploying, verify that the pods are distributed across different nodes:
```bash
kubectl get pods -o wide -l app=webserver
```
Check the **NODE** column in the output to ensure that each pod is running on a different node.

### Best Practices
- `Use Labels and Selectors Effectively`: Ensure nodes and pods are appropriately labeled to make the most out of affinity and anti-affinity features.
- `Balance Requirements and Preferences`: Use required rules for critical constraints and preferred rules to guide scheduling without enforcing it strictly, thus maintaining flexibility.
- `Monitor Cluster Performance`: Node affinity and anti-affinity rules can affect cluster resource utilization and scheduling efficiency. Monitor your cluster to ensure that it remains balanced and performant.

## Conclusion
Node `affinity` and `anti-affinity` are powerful features in Kubernetes that offer granular control over pod placement. By mastering these concepts, you can optimize your deployments for performance, reliability, and compliance. Whether you’re ensuring that your pods are running on hardware-equipped nodes or spreading workloads across zones for high availability, affinity rules are indispensable tools in your arsenal.