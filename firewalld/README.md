# Firewalld

Currently, this state only supports installing, enabling and disabling firewalld.


## OS Support

* CentOS 7.x only


## State Files

* `init.sls`

    * Ensures that the firewalld package is installed

* `enabled.sls`

    * Ensures that the firewalld service is running and enabled

* `disabled.sls`

    * Ensures that the firewalld service is disabled
