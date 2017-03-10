# Base Install

Installs standard packages via yum repo.

See `init.sls` for the complete package list.


## OS Support

* CentOS 6.x
* CentOS 7.x


## State Files

* `init.sls`

    * Installs base packages

* `dmidecode.sls`

    * Installs dmidecode
    * This has been made a separate state file because it is a salt-minion requirement, and not all minions make use of the base_install state


## Dependencies

* `yumrepos.centos`
* `yumrepos.epel`
