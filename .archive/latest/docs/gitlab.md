## Restoring GitLab

Assuming backup has already been taken using gitlab `toolbox`

Things to consider
- If you are restoring a backup taken from another instance, you must migrate your existing instance
using object storage before taking the backup. See [issue 646](https://gitlab.com/gitlab-org/charts/gitlab/-/issues/646).
- It is recommended that you restore a backup to the same version of GitLab on which it was created.
- GitLab backup restores are taken by running the `backup-utility` command on the `toolbox` pod provided in the chart.
- Before running the restore for the first time, you should ensure the `toolbox` is properly configured for access to object storage.

### Restore the rails secrets
The GitLab chart expects rails secrets to be provided as a kubernetes secret with content in YAML. If you are restoring the secret from linux package instance, secrets are stored in JSON format in the `/etc/gitlab/gitlab-secrets.json` file. To convert the file and create the secret in YAML format :

1. Copy the file `/etc/gitlab/gitlab-secrets.json` to the workstation where you can run `kubectl` commands.
2. Install `yq` tool (version 4.21.1 or later) on your workstation.
3. Run the following command to convert your `gitlab-secrets.json` to YAML format:
```
yq -P '{"production": .gitlab_rails}' gitlab-secrets.json -o yaml >> gitlab-secrets.yaml
```
4. Check that the new `gitlab-secrets.yaml` file has the following contents:
```
production:
  db_key_base: <your key base value>
  secret_key_base: <your secret key base value>
  otp_key_base: <your otp key base value>
  openid_connect_signing_key: <your openid signing key>
  active_record_encryption_primary_key:
  - 'your active record encryption primary key'
  active_record_encryption_deterministic_key:
  - 'your active record encryption deterministic key'
  active_record_encryption_key_derivation_salt: 'your active record key derivation salt'
```

To restore the rails secret from a YAML file:
1. Find the object name for rails secrets:
```
kubectl --context prod get secrets -n dev | grep rails-secret
```
2. Delete the existing rails secret:
```
kubectl --context prod delete secrets gitlab-rails-secret
```
3. Create new secret using the same name as the old, and passing in your local YAML file:
```
kubectl --context prod -n dev create secret generic gitlab-rails-secret --from-file=secrets.yml=gitlab-secrets.yaml
```
4. In order to use the newly created rail secrets, the webservice, sidekiq and toolbox pods need to be restarted. The safest way to restart those pods is to run:
```
kubectl --context prod -n dev delete pods -lapp=sidekiq,release=gitlab
kubectl --context prod -n dev delete pods -lapp=webservice,release=gitlab
kubectl --context prod -n dev delete pods -lapp=toolbox,release=gitlab
```

### Restoring the backup file
The steps for restoring a GitLab installation are
1. Make sure you have running GitLab instance by deploying the charts. Ensure the `toolbox` pod is enable and running by executing the following command
```
kubectl --context prod -n dev get pods -lrelease=gitlab,app=toolbox
```
2. Get the tarball ready in any of the above locations. Make sure it is named in the `<timestamp>_gitlab_backup.tar` format. Read what the [backup timestamp](https://docs.gitlab.com/ee/administration/backup_restore/backup_gitlab.html#backup-timestamp) is about.
3. Take notes the current number of replicas for database clients for subsequent restart:
```
kubectl --context prod -n dev get deploy -lapp=sidekiq,release=gitlab -o jsonpath='{.items[].spec.replicas}{"\n"}'
kubectl --context prod -n dev get deploy -lapp=webservice,release=gitlab -o jsonpath='{.items[].spec.replicas}{"\n"}'
# if you enable prometheus on gitlab chart only
kubectl --context prod -n dev get deploy -lapp=prometheus,release=gitlab -o jsonpath='{.items[].spec.replicas}{"\n"}'
```
4. Stop the clients of the database to prevent locks interfering with the restore process:
```
kubectl --context prod -n dev scale deploy -lapp=sidekiq,release=gitlab --replicas=0
kubectl --context prod -n dev scale deploy -lapp=webservice,release=gitlab --replicas=0
# if you enable prometheus on gitlab chart only
kubectl --context prod -n dev scale deploy -lapp=prometheus,release=gitlab --replicas=0
```
5. Run the backup utility to restore the tarball
```
kubectl --context prod -n dev -lrelease=gitlab,app=toolbox exec -it -- backup-utility --restore -t <timestamp>
```
Here, `<timestamp>` is from the name of the tarball stored in gitlab-backups bucket. In case you want to provide a public URL, use the following command.
```
kubectl --context prod -n dev -lrelease=gitlab,app=toolbox exec -it -- backup-utility --restore -f <URL>
```
You can also provide a local path as a URL as long as its in the format: `file:///<path>`.
6. The restoration process will erase the existing contents of database, move existing repositories to temporary locations and extract the contents of the tarball. Repositories will be moved to their corresponding locations on the disk and other data like artifacts, uploads, LFS, etc will be uploaded to corresponding buckets in Object storage.
7. After restore complete we need to restart the application
```
kubectl --context prod -n dev scale deploy -lapp=sidekiq,release=<helm release name> --replicas=<value>
kubectl --context prod -n dev -lapp=webservice,release=<helm release name> --replicas=<value>
kubectl --context prod -n dev -lapp=prometheus,release=<helm release name> --replicas=<value>
```
During restoration, the backup tarball needs to be extracted to disk. This means the Toolbox pod should have disk of necessary size available. For more details and configuration please see the Toolbox documentation.
