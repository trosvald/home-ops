---
id: ups
title: UPS
---
As im writing this docs, my homelab using 2(*two*) ups, one for the network and storage devices and the others for my compute node.

## Network & Storage UPS
Im using modified version [APC Smart-UPS 1500VA](https://www.apc.com/il/en/product/SUA1500I/apc-smartups-1500va-usb-serial-230v/) using 2x 12v 65Ah external [VRLA](https://en.wikipedia.org/wiki/VRLA_battery) battery in series.It protect my [Network](network) device, [Hassio](compute#smarthome), [NAS](storage#production-storage), [Backup Storage](storage#disks-backup) and my [Tape Library](storage#tapes-backup) connected via [APC Metered Rack PDU AP7821](https://www.apc.com/id/en/product/AP7821/rack-pdu-metered-1u-16a-208-230v-8-c13/).

![APC](https://download.schneider-electric.com/files?p_Doc_Ref=SUA1500IX38_FR_V&p_File_Type=rendition_369_jpg&default_image=DefaultProductImage.png)

:::info
This UPS are monitored using [Network UPS Tools](https://networkupstools.org/) hassio addons.
:::

## Compute UPS
For protecting all my compute node i opted for rackmounted [APC Smart-UPS RT 2000RMXL](https://www.apc.com/id/en/product/SURT2000RMXLI/apc-smartups-rt-2000va-230v-rackmount-2u-6x-iec-60320-c13-3x-iec-jumpers-outlets/) with 2(*two*) 48v external battery pack [APC SURT48RMXLBP](https://www.apc.com/id/en/product/SURT48RMXLBP/apc-smartups-rt-48v-rm-battery-pack/). All devices connected via [APC Rack ATS AP4423](https://www.apc.com/id/en/product/AP4423/rack-ats-230v-16a-c20-in-8-c13-1-c19-out/).

![APC](/img/docs/Surt2000xli.webp)

:::info
This UPS are monitored using [SNMP](https://en.wikipedia.org/wiki/Simple_Network_Management_Protocol/) via APC UPS Management Card 2 [AP9631](https://www.apc.com/id/en/product/AP9631/ups-network-management-card-2-with-environmental-monitoring/).
:::