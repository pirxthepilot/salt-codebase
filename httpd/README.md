# HTTPD Configuration


## OS Support

* CentOS 6.x
* CentOS 7.x


## State Files

* `init.sls`

    * Ensures httpd is installed and running
    * Calls `config.sls` and `mod_ssl.sls`

* `config.sls`

    * Deploys default httpd options
    * Managed files:
        * `/etc/httpd/conf.d/00_defaults.conf`
        * `/etc/httpd/conf.d/00_ssl_defaults.conf`

* `mod_ssl.sls`

    * Ensures mod_ssl is installed


## Version Locks

* `httpd`
* `mod_ssl`
