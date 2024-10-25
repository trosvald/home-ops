---
id: cloud
title: Cloud Services
---
While most of my infrastructure and workloads are self-hosted I do rely upon the cloud for certain key parts of my setup. This saves me from having to worry about two things:

- Dealing with chicken/egg scenarios
- Services I critically need whether my cluster is online or not.

| Service                                    | Use                                                            | Cost           |
|--------------------------------------------|----------------------------------------------------------------|----------------|
| [1Password](https://1password.com/)        | Secrets with [External Secrets](https://external-secrets.io/)  | ~$55/yr        |
| [Cloudflare](https://www.cloudflare.com/)  | Domains, Workers, Pages, and R2                                | ~$30/yr        |
| [GCP](https://cloud.google.com/)           | Voice interactions with Home Assistant over Google Assistant   | Free           |
| [GitHub](https://github.com/)              | Hosting this repository and continuous integration/deployments | Free           |
| [Let's Encrypt](https://letsencrypt.org/)  | Issuing SSL Certificates with Cert Manager                     | Free           |
| [Zoho](https://zoho.com/)                  | Email Hosting                                                  | Free 5 users   |
| [Telegram](https://telegram.org/)          | Kubernetes Alerts and application notifications                | Free           |
|                                            |                                                                | Total: ~$8/mo  |