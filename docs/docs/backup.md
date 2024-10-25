---
id: storage
title: Storage
---
It's been a year sinced i've migrating my [TrueNAS SCALE](https://www.truenas.com/truenas-scale/) node into [RedHat Enterprise Linux 8](https://access.redhat.com/products/red-hat-enterprise-linux) installed [ZFS](https://en.wikipedia.org/wiki/ZFS) on top of it for serving [iSCSI](https://en.wikipedia.org/wiki/ISCSI), [NFS](https://en.wikipedia.org/wiki/Network_File_System), [SMB](https://en.wikipedia.org/wiki/Server_Message_Block) and [Object Storage](https://min.io/) services.

Below are some details about my homelab production storage and backup devices.

## Production Storage
Using old Dell [PowerEdge R720xd](https://i.dell.com/sites/content/shared-content/data-sheets/en/Documents/Dell-PowerEdge-R720XD-Spec-Sheet.pdf) with following spec :

| **ITEM**          | **DESCRIPTION**                                                   |
|-------------------|-------------------------------------------------------------------|
| **CPU**           | 1x Intel Xeon E5-2660v2, 2.2GHz, 10C/20T                          |
| **RAM**           | 8x 32GB DDR3 ECC 1066 MHz 256GB                                   |
| **DISKS**         | 4x 12TB HDD (mirror-pool0)                                        |
|                   | 8x 4TB HDD (RAIDZ1-pool1)                                         |
|                   | 2x Intel DCS3610 SSD 800GB (OS)                                   |
| **NIC**           | 2x 1GBase-T (I350); 2x 10GBase-R (X520)                           |
| **FC HBA**        | 1x Dual Port Emulex LPe12002 (direct connect to my tape library)  |

:::info
Production storage are running `24x7`.
:::

## Backups
### Disks Backup
For disk backup im using old [Synolgy DS1817+](https://www.storagereview.com/review/synology-diskstation-ds1817-nas-review) with 8x 8TB HDD in RAID6 configuration with `~43TB` usable space, 16GB RAM and it has `4x 1Gbps` and `2x 10Gbps` NIC.

:::info
Power on-demand when backup scheduled occured.
:::

### Tapes Backup
In early 2024 i bought [IBM TS3200](https://lenovopress.lenovo.com/tips1304-ibm-ts3100-and-ts3200-tape-libraries-for-lenovo) tape library complete with 4 (*four*) IBM LTO-7 FC HH Drive for about `~600USD`, after i tested it turns out that 2 of 4 drive are dead. I loads 24x LTO6 tapes and 24x LTO7 tapes, setup direct connect FC to my [NAS](storage#production-storage) and install [Bacula](https://www.bacula.org/) on it. 

:::info
Power on-demand when backup scheduled occured.
:::
