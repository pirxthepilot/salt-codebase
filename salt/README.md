# Salt Master and Minion Configuration


## OS Support

* CentOS 6.x
* CentOS 7.x


## State Files

* `master.sls`

    * Ensures `salt-master` is installed and running
    * Deploys additional salt-master configurations


* `minion.sls`

    * Ensures `salt-minion` is installed and running
    * Deploys default salt-minion configurations
    * Managed file:
        * `/etc/salt/minion.d/backupmode.conf`

* `minion_mysql.sls`

    * Installs salt mysql prerequisite (MySQL-python)
    * Deploys the salt-minion MySQL configuration
    * Managed file:
        * `/etc/salt/minion.d/mysql.conf`

* `minion_update.sls`

    * NOT FOR HIGHSTATE USE!
    * Usage: `salt <hosts> state.apply salt.minion_update`
    * Updates minions to the latest version of Salt


## Dependencies

* `yumrepos.saltstack`
* `misc_installs.mysql_python`
