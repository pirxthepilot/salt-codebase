# Salt Master and Minion Configuration


## OS Support

* CentOS 6.x
* CentOS 7.x


## State Files

* `master/init.sls`

    * Ensures `salt-master` is installed and running
    * Deploys additional salt-master configurations


* `minion/init.sls`

    * Ensures `salt-minion` is installed and running
    * Deploys default salt-minion configurations
    * Managed file:
        * `/etc/salt/minion.d/backupmode.conf`

* `minion/mysql.sls`

    * Installs salt mysql prerequisite (MySQL-python)
    * Deploys the salt-minion MySQL configuration
    * Managed file:
        * `/etc/salt/minion.d/mysql.conf`


## Dependencies

* `yumrepos.saltstack`
* `base_install.dmidecode` (salt.minion only)
* `misc_installs.mysql_python` (salt.minion.mysql only)
