# Percona Server


## OS Support

* CentOS 6.x
* CentOS 7.x


## State Files

* `shared.sls`

    * Ensures standard required Percona shared package is installed, and dependencies met

* `client.sls`

    * Ensures standard required Percona client package is installed, and dependencies met
    * Also installs `Percona-Server-shared`

* `server.sls`

    * Ensures standard required Percona server packages are installed, and dependencies met
    * Also installs `Percona-Server-shared` and `Percona-Server-client`
    * Ensures the mysql/mysqld service is running and enabled at boot time

* `server_config.sls`

    * Performs default database configuration/hardening, such as the removal of the test databases and anonymous users
    * Consider only running this the first time Percona is installed, and not including it in highstate
    * Note that this does not set a password for `'root'@'localhost'`. Please do this manually!


## Dependencies            

* `yumrepos.percona`
* `salt.minion_mysql`


## Version Locks

* `Percona-Server-server-56`
