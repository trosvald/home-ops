---
id: network
title: Network
---
![SRX320](/img/docs/SRX320.webp)

Network device is core infrastructure for the entire homelab so each device(s) can communicates to each others and accessing the internet smoothly. My homelab network devices consist of :

1. [Juniper SRX320](https://www.juniper.net/us/en/products/security/srx-series/srx320-enterprise-firewall.html) :
    Act as a gateway (router) and firewall for all homelab devices. Its also provide several services such as [DHCP](https://efficientip.com/glossary/what-is-dhcp-and-why-is-it-important/) server, [eBGP](https://www.geeksforgeeks.org/difference-between-ebgp-and-ibgp/) peer with my [Cilium](https://cilium.io/) k8s cluster and primary [NTP](https://en.wikipedia.org/wiki/Network_Time_Protocol) server.

2. [TP-LINK SG3428X](https://www.tp-link.com/id/business-networking/omada-sdn-switch/tl-sg3428x/) :
    Function as core switch for all homelab and home devices. Replacing couple of [Juniper EX-2300-24P](https://www.juniper.net/us/en/products/switches/ex-series/ex2300-ethernet-switch-datasheet.html) reducing my homelab energy usage. Also it has `4x 10Gbps SFP+` ports.This core switch are directly connected to Juniper SRX320 via [LACP](https://en.wikipedia.org/wiki/Link_aggregation) using `2x 1GBase-T`

3. [TP-LINK SX3008F](https://www.tp-link.com/id/business-networking/managed-switch/tl-sx3008f/) :
    Two of this switch act as [ToR](https://www.techtarget.com/searchnetworking/definition/top-of-rack-switching) switch for my compute and storage server, having `8x 10Gbps SFP+` ports on each unit. Directly connected to core switch.

4. [TP-LINK SG2210MP](https://www.tp-link.com/id/business-networking/omada-sdn-switch/tl-sg2210mp/) :
    PoE switch for all my wireless APs and IP Camera, directly connected via [LACP](https://en.wikipedia.org/wiki/Link_aggregation) to Juniper SRX320 using `2x 1Gbps SFP`.  

5. [TP-LINK EAP653](https://www.tp-link.com/id/business-networking/omada-wifi-ceiling-mount/eap653/) :
    WiFi6 wireless access point for whole home.

:::info Network Config and Management
Using [Omada](https://www.tp-link.com/us/business-networking/omada-sdn-controller/omada-software-controller/) software controller for all TP-LINK devices, and [Ansible](https://www.ansible.com/) for Juniper SRX320.
:::