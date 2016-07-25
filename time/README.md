# Time Configuration


## OS Support

* CentOS 6.x (timezone only)
* CentOS 7.x


## State Files

* `init.sls`

    * Simply calls the states in this category

* `chrony.sls`

    * Ensures `chrony` is installed and `chronyd` is running
    * Deploys the chrony configuration
    * Managed file:
        * `/etc/chrony.conf`

* `timezone.sls`

    * Ensures the time zone is as defined
