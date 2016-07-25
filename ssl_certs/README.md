# SSL Certificates for HTTPD

Ensures SSL certificates and keys are deployed. To use, simply include the state file of the certificate/s you want to deploy on your top.sls file. For example:

`- ssl_certs.example_com`

Then the certificate and key files must be placed under the `ssl` directory (by default) inside the target nodegroup or host in the pillar_files directory. For example, if deploying to a nodegroup, the files should be stored in `/srv/pillar_files/nodegroups/<nodegroup>/ssl`.


## OS Support

* CentOS 6.x
* CentOS 7.x


## State Files

* `init.sls`

    * Ensures that the SSL certificates directory exists (`/etc/httpd/ssl` by default)

* `example_com.sls`

    * Deploys the `example.com` SSL cert and key
    * Managed files (by default only):
        * `/etc/httpd/ssl/example.com.pem`
        * `/etc/httpd/ssl/example.com.key`

* `custom.sls`

  * Deploys custom SSL certs via pillar (see `pillar.example`)
