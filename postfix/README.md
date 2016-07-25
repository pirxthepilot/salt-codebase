# Postfix Configuration 


## OS Support

* CentOS 6.x
* CentOS 7.x


## State Files

* `init.sls`

    * Ensures `postfix` is installed, enabled and running
        * Managed only if `managed` is set to `True`
    * Files managed:
        * `/etc/postfix/main.cf`
            * Managed only if `strict_config` is set to `True`


## Dependencies

* `networking/defaults.yaml`
    * Referenced on `files/main.cf.jinja`
