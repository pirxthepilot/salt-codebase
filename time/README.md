# Time Configuration


## OS Support

* CentOS 6.x
* CentOS 7.x


## State Files

* `init.sls`

    * Simply calls the states in this category

* `chrony.sls` (CentOS 7)

    * Ensures `chrony` is installed and `chronyd` is running
    * Deploys the chrony configuration
    * Managed file:
        * `/etc/chrony.conf`

* `ntp.sls` (CentOS 6)

    * Ensures `ntp` is installed and `ntpd` is running
    * Deploys the ntp configuration
    * Managed file:
        * `/etc/ntp.conf`

* `timezone.sls`

    * Ensures the time zone is as defined
