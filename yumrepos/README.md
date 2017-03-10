# Yum Repositories

Deploys external or internal yum repositories


## State Files

* `centos.sls`

    * Switches between the default (external) and internal CentOS-Base repos
    * OS support:
      * CentOS 6.x
      * CentOS 7.x

* `epel.sls`

    * Adds the EPEL repository
    * OS support:
        * CentOS 5.x (external repos only)
        * CentOS 6.x
        * CentOS 7.x

* `saltstack.sls`

    * Adds the official Saltstack repository
    * OS support:
        * CentOS 5.x (external repos only)
        * CentOS 6.x
        * CentOS 7.x

* `webtatic.sls`

    * Adds the Webtatic repository
    * OS support:
        * CentOS 6.x
        * CentOS 7.x

* `percona.sls`

    * Adds the Percona repository
    * OS support:
        * CentOS 6.x
        * CentOS 7.x

* `pbiso.sls`

    * Adds the PBIS Open repository (maintained by beyondtrust.com)
    * OS support:
        * CentOS 6.x


## Dependencies

* `ca_trust`
