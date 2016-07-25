# File Repository Website

Quick file repository site deployment for hosting OS images, yum repositories, etc.

These states can be included in a highstate.

To apply the state to a minion, run:

```
salt 'minion-id' state.apply app_filerepo
```


## OS Support

* CentOS 7.x only


## State files

* `init.sls`

    * Enumerates all the state files that will be run

* `root_dir.sls`

    * Creates and configures ownership and permissions on the application root directory.

* `httpd_vhost.sls`

    * Deploys the application HTTPD config file in /etc/httpd/conf.d
