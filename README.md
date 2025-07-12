<div align="center">

<img src="https://avatars.githubusercontent.com/u/11927171" align="center" width="144px" height="144px"/>

### My Home Operations Repository

_... managed with Flux, Renovate, GitHub Actions, GitLab CI_ 🤖

</div>

<div align="center">

[![Talos](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.monosense.io%2Fquery%3Fformat%3Dendpoint%26metric%3Dtalos_version&style=for-the-badge&logo=talos&logoColor=white&color=blue&label=%20)](https://www.talos.dev/)&nbsp;&nbsp;
[![Kubernetes](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.monosense.io%2Fquery%3Fformat%3Dendpoint%26metric%3Dkubernetes_version&style=for-the-badge&logo=kubernetes&logoColor=white&color=blue&label=%20)](https://www.talos.dev/)&nbsp;&nbsp;
[![Renovate](https://img.shields.io/github/actions/workflow/status/trosvald/home-ops/renovate.yaml?branch=main&label=&logo=drone&style=for-the-badge&color=blue)](https://github.com/trosvald/home-ops/actions/workflows/renovate.yaml)&nbsp;&nbsp;
[![Flux](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.monosense.io%2Fflux_version&style=for-the-badge&logo=flux&logoColor=white&color=blue&label=%20)](https://fluxcd.io)&nbsp;&nbsp;
[![Power](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.monosense.io%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_power_usage&label=&logo=amp&style=for-the-badge&color=blue)](https://github.com/kashalls/kromgo/)



</div>

<div align="center">

[![Home-Internet](https://img.shields.io/endpoint?url=https%3A%2F%2Fhealthchecks.io%2Fb%2F2%2Fdb69df2e-c93d-4e39-b9f6-6689be941116.shields?color=brightgreeen&label=WAN&style=for-the-badge&logo=battle.net&logoColor=white)](https://status.monosense.io)&nbsp;&nbsp;
[![Status-Page](https://img.shields.io/endpoint?url=https%3A%2F%2Fhealthchecks.io%2Fb%2F2%2Fdb69df2e-c93d-4e39-b9f6-6689be941116.shields?color=brightgreeen&label=Status%20Page&style=for-the-badge&logo=statuspage&logoColor=white)](https://status.monosense.io)&nbsp;&nbsp;
[![Alertmanager](https://img.shields.io/endpoint?url=https%3A%2F%2Fhealthchecks.io%2Fb%2F2%2Fec273744-4a6a-4726-a8e8-1732e489ffc6.shields&style=for-the-badge&logo=prometheus&logoColor=white&label=Alertmanager)](https://status.monosense.io)

</div>
<div align="center">

[![Age-Days](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.monosense.io%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_age_days&style=flat-square&label=Age)](https://github.com/kashalls/kromgo/)&nbsp;&nbsp;
[![Uptime-Days](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.monosense.io%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_uptime_days&style=flat-square&label=Uptime)](https://github.com/kashalls/kromgo/)&nbsp;&nbsp;
[![Node-Count](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.monosense.io%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_node_count&style=flat-square&label=Nodes)](https://github.com/kashalls/kromgo/)&nbsp;&nbsp;
[![Pod-Count](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.monosense.io%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_pod_count&style=flat-square&label=Pods)](https://github.com/kashalls/kromgo/)&nbsp;&nbsp;
[![CPU-Usage](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.monosense.io%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_cpu_usage&style=flat-square&label=CPU)](https://github.com/kashalls/kromgo/)&nbsp;&nbsp;
[![Memory-Usage](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.monosense.io%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_memory_usage&style=flat-square&label=Memory)](https://github.com/kashalls/kromgo/)&nbsp;&nbsp;

</div>

---

## 📖 Overview

This is a mono repository for my home infrastructure and Kubernetes cluster. I try to adhere to Infrastructure as Code (IaC) and GitOps practices using tools like [Ansible](https://www.ansible.com/), [Terraform](https://www.terraform.io/), [Kubernetes](https://kubernetes.io/), [Flux](https://github.com/fluxcd/flux2), [Renovate](https://github.com/renovatebot/renovate), and [GitHub Actions](https://github.com/features/actions).

---

## <img src="https://fonts.gstatic.com/s/e/notoemoji/latest/2699_fe0f/512.gif" alt="⚙" width="20" height="20"> Hardware

<details>
  <summary>Click to see my rack</summary>

  <!-- <img src="https://github.com/user-attachments/assets/43bd0ca8-a1a8-49d5-9b9a-04fbdcecdd3f" align="center" alt="rack"/> -->
  ![rack](./docs/src/assets/rack.png)
</details>

| Device                        | Count | OS Disk Size  | Data Disk Size              | Ram   | Operating System | Purpose                 |
|-------------------------------|-------|---------------|-----------------------------|-------|------------------|-------------------------|
| Thinkcentre M920x             | 3     | 512GB SSD     | 1TB NVME + 512GB NVME       | 64GB  | Talos            | Kubernetes              |
| Synology NAS RS1221+          | 1     | -             | 8x12TB HDD                  | 32GB  | DSM 7            | NFS                     |
| TESmart 8 Port KVM Switch     | 1     | -             | -                           | -     | -                | Network KVM             |
| Juniper SRX320                | 1     | -             | -                           | -     | JUNOS            | Router                  |
| TPLINK SX3008F                | 2     | -             | -                           | -     | -                | 10GGb ToR Switch        |
| TPLINK SG2210MP               | 1     | -             | -                           | -     | -                | PoE Switch              |
| TPLINK SG3428X                | 1     | -             | -                           | -     | -                | Aggregation Switch      |
| APC AP4421                    | 1     | -             | -                           | -     | -                | ATS/PDU                 |
| APC SURT2000RM XL + 2x BP     | 1     | -             | -                           | -     | -                | UPS                     |
---
## <img src="https://fonts.gstatic.com/s/e/notoemoji/latest/1f331/512.gif" alt="🌱" width="20" height="20"> Kubernetes

This semi hyper-converged cluster operates on [Talos Linux](https://github.com/siderolabs/talos), an immutable and ephemeral Linux distribution tailored for [Kubernetes](https://github.com/kubernetes/kubernetes), and is deployed on bare-metal workstations. [Rook](https://github.com/rook/rook) supplies my workloads with persistent block, object, and file storage, while a separate server handles media file storage. The cluster is designed to enable a full teardown without any data loss.

There is a template at [onedr0p/cluster-template](https://github.com/onedr0p/cluster-template) if you want to follow along with some of the practices I use here.

### Core Components

- [actions-runner-controller](https://github.com/actions/actions-runner-controller): Self-hosted Github runners.
- [cert-manager](https://github.com/cert-manager/cert-manager): Creates SSL certificates for services in my cluster.
- [cilium](https://github.com/cilium/cilium): eBPF-based networking for my workloads.
- [cloudflared](https://github.com/cloudflare/cloudflared): Enables Cloudflare secure access to my routes.
- [external-dns](https://github.com/kubernetes-sigs/external-dns): Automatically syncs ingress DNS records to a DNS provider.
- [external-secrets](https://github.com/external-secrets/external-secrets): Managed Kubernetes secrets using [1Password Connect](https://github.com/1Password/connect).
- [multus](https://github.com/k8snetworkplumbingwg/multus-cni): Multi-homed pod networking.
- [rook](https://github.com/rook/rook): Distributed block storage for peristent storage.
- [spegel](https://github.com/spegel-org/spegel): Stateless cluster local OCI registry mirror.
- [volsync](https://github.com/backube/volsync): Backup and recovery of persistent volume claims.

### GitOps

[Flux](https://github.com/fluxcd/flux2) watches my [kubernetes](./kubernetes) folder (see Directories below) and makes the changes to my clusters based on the state of my Git repository.

The way Flux works for me here is it will recursively search the [kubernetes/apps](./kubernetes/apps) folder until it finds the most top level `kustomization.yaml` per directory and then apply all the resources listed in it. That aforementioned `kustomization.yaml` will generally only have a namespace resource and one or many Flux kustomizations (`ks.yaml`). Under the control of those Flux kustomizations there will be a `HelmRelease` or other resources related to the application which will be applied.

[Renovate](https://github.com/renovatebot/renovate) monitors my **entire** repository for dependency updates, automatically creating a PR when updates are found. When some PRs are merged Flux applies the changes to my cluster.

### Directories

This Git repository contains the following directories under [kubernetes](./kubernetes).

```sh
📁 kubernetes      # Kubernetes cluster defined as code
├─📁 apps          # Apps deployed into my cluster grouped by namespace (see below)
├─📁 components    # Re-usable kustomize components
└─📁 flux          # Flux system configuration
```
