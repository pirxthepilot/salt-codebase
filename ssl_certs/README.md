# SSL Certificates for HTTPD

Ensures SSL certificates and keys are deployed.


## OS Support

* CentOS 6.x
* CentOS 7.x


## State Files

* `init.sls`

    * Ensures that the SSL certificates directory exists (`/etc/httpd/ssl` by default)

* `custom.sls`

    * Deploys custom SSL certs and keys via pillar
