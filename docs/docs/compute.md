---
id: compute
title: Compute
---

![m920x](/img/docs/m920x.webp)

Software does not exists without hardware backing it up and to be honest, I could have done pretty much all this via some cloud providers, but then it breaks my goal for reducing cloud service cost. My home lab compute node(s) are categorized with what services that they provides. There are 2 (*two*) category :

## Core Infra
Core infra are runs all required services such as `DNS`, `LDAP`, `NTP`, `DHCP-Proxy`, `Home Assistant` etc.

### Virtualization
3 (*three*) units of [Lenovo Thinkcentre M910q](https://www.lenovo.com/us/en/p/desktops/thinkcentre/m-series-tiny/thinkcentre-m910q/11tc1mt910q), with following identical spec :
- **CPU** : [Intel Core i7-7700T](https://www.intel.co.id/content/www/id/id/products/sku/97122/intel-core-i77700t-processor-8m-cache-up-to-3-80-ghz/specifications.html) 2.9GHz, 4c/8t
- **RAM** : DDR4 32GB 
- **STORAGE** : 800GB SATA SSD
- **NIC** : Intel GigabitEthernet I219-LM

:::info :es-hide-title:
`[WIP]` : Proxmox or XCP-ng will be deployed on this node(s).
:::

### Container Services
1 (*one*) unit of [Lenovo Thinkcentre M920x](https://www.lenovo.com/us/en/p/desktops/thinkcentre/m-series-tiny/thinkcentre-m920x/11tc1mtm92x), with following spec :
- **CPU** : [Intel Core i5-8500](https://www.intel.co.id/content/www/id/id/products/sku/129939/intel-core-i58500-processor-9m-cache-up-to-4-10-ghz/specifications.html) 3.0GHz, 6c/6t
- **RAM** : DDR4 16GB
- **STORAGE** : NvME 512GB
- **NIC** : Intel GigabitEthernet I219-LM

:::info :es-hide-title:
`[IN PRODUCTION]` : Podman on [Fedora IoT](https://fedoraproject.org/iot/) for all supporting services.
:::

### Smarthome  
1 (*one*) unit of [HP ProDesk 400 G1 Mini](https://support.hp.com/rs-en/product/setup-user-guides/hp-prodesk-400-g1-desktop-mini-pc/7519860), with following spec :
- **CPU** : [Intel Core i5-4460T](https://www.intel.co.id/content/www/id/id/products/sku/78927/intel-core-i54460t-processor-6m-cache-up-to-2-70-ghz/specifications.html) 1.9GHz, 4c/4t
- **RAM** : DDR3 8GB
- **STORAGE** : SATA SSD 120GB
- **NIC** : Intel GigabitEthernet I217-LM

:::info :es-hide-title:
`[IN PRODUCTION]` : Dedicated HASSIO (Home Assistant) and Zigbee2MQTT.
:::

## Kubernetes 
Kubernetes cluster with [Talos Linux](https://talos.dev), utilize [Infrastructure as Code](https://en.wikipedia.org/wiki/Infrastructure_as_code) and [GitOps](https://www.gitops.tech/) principles to automate provisioning, operating, and updating. Using the tools like [Ansible](https://www.ansible.com/), [Opentofu](https://opentofu.org/), [Flux](https://github.com/fluxcd/flux2), [Renovate](https://github.com/renovatebot/renovate), and [GitHub Actions](https://github.com/features/actions). Below are my kubernetes cluster node(s) in details :

### Control Plane
3 (*three*) unit of [Lenovo Thinkcentre M720q](https://www.lenovo.com/us/en/p/desktops/thinkcentre/m-series-tiny/thinkcentre-m720q/11tc1mtm72q) with following identical spec :
- **CPU** : [Intel Core i7-8700T](https://www.intel.co.id/content/www/id/id/products/sku/129948/intel-core-i78700t-processor-12m-cache-up-to-4-00-ghz/specifications.html) 2.4GHz, 6c/12t
- **RAM** : DDR4 64GB 
- **STORAGE** : 500GB SSD (OS), NvME 1TB Gen3 (CEPH) 
- **NIC** : Intel GigabitEthernet I219-V (PXE Only), 2x 10Gbps Mellanox ConnectX 3 Pro
### Worker
3 (*three*) unit of [Lenovo Thinkcentre M920x](https://www.lenovo.com/us/en/p/desktops/thinkcentre/m-series-tiny/thinkcentre-m920x/11tc1mtm92x) with following identical spec :
- **CPU** : [Intel Core i7-8700T](https://www.intel.co.id/content/www/id/id/products/sku/129948/intel-core-i78700t-processor-12m-cache-up-to-4-00-ghz/specifications.html) 2.4GHz, 6c/12t
- **RAM** : DDR4 64GB 
- **STORAGE** : 500GB SSD (OS), NvME 1TB Gen4 (CEPH) 
- **NIC** : Intel GigabitEthernet I219-LM (PXE Only), 2x 10Gbps Mellanox ConnectX 3 Pro

