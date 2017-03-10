# Custom Trusted CA Certificates 


The certificate and key files must be placed under the `ca_trust` directory (by default) inside the target nodegroup or host in the pillar_files directory.


## OS Support

* CentOS 6.x
* CentOS 7.x


## State Files

* `init.sls`

    * Ensures that the CA certificate is deployed on /etc/pki/ca-trust/source/anchors
    * Runs 'update-ca-trust' (and also 'update-ca-trust enable' on CentOS 6) every time a new cert is deployed


## Adding new trusted CA certs

* Place the certificate file in the proper place in pillar_files
* Add a ca_trust entry on the affected hosts' or groups' pillar - see `pillar.example` for an example
