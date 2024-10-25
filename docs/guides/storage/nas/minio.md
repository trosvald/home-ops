---
id: object-storage
title: MinIO
---

## Overview
Object storage, also known as object-based storage, is a computer data storage architecture designed to handle large amounts of unstructured data.

Unlike other architectures, it designates data as distinct units, bundled with metadata and a unique identifier that can be used to locate and access each data unit.

Much of today’s data is unstructured: email, media and audio files, web pages, sensor data, and other types of digital content that do not fit easily into traditional databases. As a result, finding efficient and affordable ways to store and manage it has become problematic. Increasingly, object storage has become the preferred method for storing static content, data arches, and backups. Object storage roles in my homelab are :

- Stores backup from my k8s cluster with volsync restic.

- Stores backup and WAL from my PostgreSQL (Crunchy PGO.)

- Stores logs from my homelab devices.

- Stores files from my OCIS kubernetes instance.

- Stores my assets data for websites act like a local CDN.

:::info 
I’ll be using `S3` compatible object-based storage [MinIO](https://min.io/) for my on-premise homelab backup environment and **Cloudflare R2** for offsites backup, following [3-2-1](https://www.veeam.com/blog/321-backup-rule.html) backup strategy.
:::

### MinIO Install
:::caution
The procedures on this page cover deploying **MinIO** in a Single-Node Single-Drive (SNSD) configuration. SNSD deployments use a zero-parity erasure coded backend that provides no added reliability or availability beyond what the underlying storage volume implements.
:::

:::info
For extended development or production environments, deploy **MinIO** in a [Multi-Node Multi-Drive](https://min.io/docs/minio/linux/operations/install-deploy-manage/deploy-minio-multi-node-multi-drive.html#minio-mnmd) (Distributed) topology
:::

1. Download and install **MinIO** `RPM` package
```bash
# Download MinIO RPM package
[user@host ~]$ wget https://dl.min.io/server/minio/release/linux-amd64/minio-20241002175041.0.0-1.x86_64.rpm
# Install MinIO package
[user@host ~]$ sudo dnf -y install minio.rpm
```

2. Create ZFS dataset for MinIO (if you have not yet created in previous steps)
```bash
[user@host ~]$ sudo zfs create pool1/minio
```

3. Create user and group for **MinIO** `systemd`
```bash
[user@host ~]$ sudo groupadd -r minio-user
[user@host ~]$ sudo useradd -M -r -g minio-user minio-user
[user@host ~]$ sudo chown minio-user:minio-user /pool1/minio
```

4. After changing ownership of the object storage directory, we will need to create a new configuration directory `/etc/minio`, and the default config file for running the **MinIO** service at `/etc/default/minio`
```bash
[user@host ~]$ sudo mkdir -p /etc/minio
[user@host ~]$ sudo vi /etc/default/minio

# Add following configuration and save, match it with your environment
MINIO_ROOT_USER="your_minio_root_user"
MINIO_VOLUMES="/pool1/minio"
MINIO_OPTS="-C /etc/minio --address :9000 --console-address :9001"
MINIO_ROOT_PASSWORD="your_minio_root_password"
MINIO_BROWSER_REDIRECT_URL="https://console.domain.tld"
MINIO_PROMETHEUS_JOB_ID="minio"
MINIO_PROMETHEUS_URL="https://prometheus.domain.tld"
MINIO_PROMETHEUS_AUTH_TYPE="public"
MINIO_SERVER_URL="https://s3.domain.tld"

# Change ownership to minio-user
[user@host ~]$ sudo chown -R minio-user:minio-user /etc/minio
[user@host ~]$ sudo chown minio-user:minio-user /etc/default/minio
```

5. Running **MinIO** as a `systemd` service. If you installed **MinIO** from `RPM` package check your `/usr/lib/systemd/system/minio.service` `systemd` file and adjust accordingly.
```bash
[Unit]
Description=MinIO
Documentation=https://docs.min.io
Wants=network-online.target
After=network-online.target
AssertFileIsExecutable=/usr/local/bin/minio

[Service]
Type=notify

WorkingDirectory=/usr/local

User=minio-user
Group=minio-user
#ProtectProc=invisible
EnvironmentFile=-/etc/default/minio
ExecStart=/usr/local/bin/minio server $MINIO_OPTS $MINIO_VOLUMES
# Let systemd restart this service always
Restart=always
# Specifies the maximum file descriptor number that can be opened by this process
LimitNOFILE=1048576
# Turn-off memory accounting by systemd, which is buggy.
MemoryAccounting=no
# Specifies the maximum number of threads this process can create
TasksMax=infinity
# Disable timeout logic and wait until process is stopped
TimeoutSec=infinity
SendSIGKILL=no

[Install]
WantedBy=multi-user.target
# Built for ${project.name}-${project.version} (${project.name})
```
Save the file and exit editor when you are finished. After you have configure `systemd` service for your **MinIO**, run the following command to reload systemd manager.
```bash
# Reload systemd
[user@host ~]$ sudo systemctl daemon-reload

# Enable and start MinIO service
[user@host ~]$ sudo systemctl enable --now minio.service

# Verify if MinIO service is started without any errors
[user@host ~]$ systemctl status minio.service

● minio.service - MinIO
   Loaded: loaded (/usr/lib/systemd/system/minio.service; enabled; vendor preset: disabled)
   Active: active (running) since Fri 2024-10-04 07:22:36 WIB; 1 day 8h ago
     Docs: https://docs.min.io
 Main PID: 6022 (minio)
    Tasks: 27
   CGroup: /system.slice/minio.service
           └─6022 /usr/local/bin/minio server -C /etc/minio --address :9000 --console-address :9001 /pool1/minio

Oct 04 07:22:34 p-rh8-zfs.domain.tld systemd[1]: Starting MinIO...
Oct 04 07:22:36 p-rh8-zfs.domain.tld systemd[1]: Started MinIO.
Oct 04 07:22:36 p-rh8-zfs.domain.tld minio[6022]: MinIO Object Storage Server
Oct 04 07:22:36 p-rh8-zfs.domain.tld minio[6022]: Copyright: 2015-2024 MinIO, Inc.
Oct 04 07:22:36 p-rh8-zfs.domain.tld minio[6022]: License: GNU AGPLv3 - https://www.gnu.org/licenses/agpl-3.0.html
Oct 04 07:22:36 p-rh8-zfs.domain.tld minio[6022]: Version: RELEASE.2024-08-03T04-33-23Z (go1.22.5 linux/amd64)
Oct 04 07:22:36 p-rh8-zfs.domain.tld minio[6022]: API: https://s3.domain.tld
Oct 04 07:22:36 p-rh8-zfs.domain.tld minio[6022]: WebUI: https://console.domain.tld
Oct 04 07:22:36 p-rh8-zfs.domain.tld minio[6022]: Docs: https://min.io/docs/minio/linux/index.html
```

### Firewall
If you decided to serve your minio using standard port they provided, you need to open couple of firewall ports. You could do with either one of the following commands :

1. **Option 1** : Firewall rule for standard port MinIO
```bash
[user@host ~]$ sudo firewall-cmd --add-port={9000/tcp,9001/tcp} --permanent
[user@host ~]$ sudo firewall-cmd reload
```

2. **Option 2** : Firewall rule for **MinIO** proxied using **NGINX** on the same host.
```bash
[user@host ~]$ sudo firewall-cmd --add-service={http,https} --permanent
[user@host ~]$ sudo firewall-cmd reload
```
You’ve already succeeded installing **MinIO** SNSD. You can access your minio console from `http://FQDN_or_IP:9001`, and `S3` through `http://FQDN_or_IP:9000`. But if you opted to proxied **MinIO** using **NGINX** please follow next steps.

### NGINX
1. Install **acme.sh** for managing your LE certificates.
```bash
# Using curl
[user@host ~]$ sudo -i
[root@host ~] curl https://get.acme.sh | sh -s email=my@example.com

# Using wget
[user@host ~]$ sudo -i
[root@host ~]$ wget -O - https://get.acme.sh https://get.acme.sh | sh -s email=my@example.com

```
2. I’ll be using DNS-01 with [Cloudflare DNS](https://github.com/acmesh-official/acme.sh/wiki/dnsapi#dns_cf) provider, please check **acme.sh** supported DNS [providers](https://github.com/acmesh-official/acme.sh/wiki/dnsapi).
```bash
[root@host ~]$ vi ~/.bashrc
...

. "/root/.acme.sh/acme.sh.env"
# add following line if you used cloudflare dns
# if you have another dns provider please read
# acme.sh documentation for you dns provider
export CF_Key="your_cf_key"
export CF_Email="your_cf_email"

# Save and exit, then source your ~/.bashrc
[root@host ~]$ source ~/.bashrc
```

3. Issuing your certificate, im using `Buypass.com` CA issuer
```bash
# First time register account with an email, the mail is required by buypass.com
[root@host ~]$ acme.sh --server https://api.buypass.com/acme/directory \
    --register-account  --accountemail me@example.com

# Upon success registration, then we can issue our cert
[root@host ~]$ acme.sh --server https://api.buypass.com/acme/directory  \
    --issue -d console.domain.tld -d s3.domain.tld --dns dns_cf --keylength 4096 --force \
    --days 170
```

:::tip
Since [Buypass](https://www.buypass.com/ssl/resources/go-ssl-technical-specification) cert has **180 days** lifetime, so we have to specify `--days 170` for `acme.sh` to renew the cert at the **170th day**. If you don’t specify days, *it will renew at `60 days` by default*.
:::

4. Install **NGINX** package
```bash

# Display the available NGINX module streams:
[user@host ~]$ sudo dnf module list nginx
Red Hat Enterprise Linux 8 for x86_64 - AppStream (RPMs)
Name        Stream        Profiles        Summary
nginx       1.14 [d]      common [d]      nginx webserver
nginx       1.16          common [d]      nginx webserver
...

# If you want to install a different stream than the default, select the stream:
[user@host ~]$ sudo dnf module enable nginx:stream_version

# Install nginx package
[user@host ~]$ sudo dnf install nginx -y

# Enable and start nginx
[user@host ~]$ sudo systemctl enable --now ngix.service
```
5. **MinIO** and SSL cert for virtual host configurations
```bash
# Prepare directory where certificates will be resides
[root@host ~]$ mkdir -p /etc/nginx/certs/console.domain.tld

# Create virtual host for console access
[root@host ~]$ vi /etc/nginx/conf.d/minio-console.conf

# Create virtual host for api access
[root@host ~]$ vi /etc/nginx/conf.d/minio-console.conf
```

:::info :es-hide-title:
`/etc/nginx/conf.d/minio-console.conf`
:::
```bash
upstream minio_console {
   #least_conn;
   server 127.0.0.1:9001;
}

server {

   listen       80;
   server_name  console.domain.tld;
   return   301 https://$server_name$request_uri;
}

server {

    listen  443 ssl;
    server_name console.domain.tld;

    ssl_certificate /etc/nginx/certs/console.domain.tld/console.domain.tld-fullchain.pem;
    ssl_certificate_key /etc/nginx/certs/console.domain.tld/console.domain.tld-key.pem;

    # Allow special characters in headers
    ignore_invalid_headers off;
    # Allow any size file to be uploaded.
    # Set to a value such as 1000m; to restrict file size to a specific value
    client_max_body_size 0;
    # Disable buffering
    proxy_buffering off;
    proxy_request_buffering off;

    location / {
        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-NginX-Proxy true;

        # This is necessary to pass the correct IP to be hashed
        real_ip_header X-Real-IP;

        proxy_connect_timeout 300;

        # To support websocket
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";

        chunked_transfer_encoding off;

        proxy_pass http://minio_console/; # This uses the upstream directive definition to load balance
   }
}
```
:::info :es-hide-title:
`/etc/nginx/conf.d/minio-api.conf`
:::
```bash

upstream minio_s3 {
   #least_conn;
   server 127.0.0.1:9000;
}
server {

   listen       80;
   server_name  s3.domain.tld;
   return   301 https://$server_name$request_uri;
}

server {

    listen  443 ssl;
    server_name s3.domain.tld;

    ssl_certificate /etc/nginx/certs/console.domain.tld/console.domain.tld-fullchain.pem;
    ssl_certificate_key /etc/nginx/certs/console.domain.tld/console.domain.tld-key.pem;

    # Allow special characters in headers
    ignore_invalid_headers off;
    # Allow any size file to be uploaded.
    # Set to a value such as 1000m; to restrict file size to a specific value
    client_max_body_size 0;
    # Disable buffering
    proxy_buffering off;
    proxy_request_buffering off;

    location / {
        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        proxy_connect_timeout 300;
        # Default is HTTP/1, keepalive is only enabled in HTTP/1.1
        proxy_http_version 1.1;
        proxy_set_header Connection "";
        chunked_transfer_encoding off;

        proxy_pass http://minio_s3; # This uses the upstream directive definition to load balance
    }
}
```

6. Install `SSL Certificates`, and restart **NGINX** service
```bash

[root@host ~]$ acme.sh --install-cert -d console.domain.tld \
--key-file /etc/nginx/certs/console.domain.tld/console.domain.tld-key.pem  \
--fullchain-file /etc/nginx/certs/console.domain.tld/console.domain.tld-fullchain.pem \
--reloadcmd "systemctl restart nginx.service"
```
If you catch any error just troubleshoot and re-run the command. After success fired up your browser to `https://console.domain.tld` for accessing **MinIO** console. And if you want to test **S3** connection, easiest method is using `curl https://s3.domain.tld` from your `shell`.
