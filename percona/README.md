# Percona Server


## OS Support

* CentOS 6.x
* CentOS 7.x


# Notes

Before applying these states to a minion, ensure that default mysql packages are NOT installed:

* CentOS 6.x  - `mysql` package (`mysql-libs` is okay; Percona will replace it automatically)
* CentOS 7.x  - `mariadb` package (`mariadb-libs` is okay; Percona will replace it automatically)


# The Proper Way to deploy percona.server

It's a bit convoluted, so please bear with me.

1. Set the root and saltadmin password_hash pillars (if not yet globally set):
    * percona_server.root.password_hash
    * percona_server.saltadmin.password_hash
2. Use the saltadmin user credentials for the saltminion.mysql pillar values (if not yet globally set).
3. Run adhoc.percona.initialize. This will install, configure, and set initial parameters for Percona server, including the creation of 'saltadmin'@'localhost'.
4. Run percona.server or apply it as part of the highstate.


## State Files

* `client/init.sls`

    * Ensures standard required Percona client package is installed, and dependencies met
    * Also installs `Percona-Server-shared`

* `server/init.sls`

    * Meta state file that includes all the server states below

* `server/service.sls`

    * Ensures standard required Percona server packages are installed, and dependencies met
    * Also installs the Percona client
    * Ensures the mysql/mysqld service is running and enabled at boot time

* `server/config.sls`

    * Deploys /etc/my.cnf according to default and customized parameters via pillar
    * Configures logrotate settings for certain database server log files

* `server/users.sls`

    * Creates Percona database users and their permissions according what's declared on pillars
    * Notes:
      * This state only creates (and grants access to) users; it DOES NOT remove users that are not defined by the pillar! Unwanted users must be manually deleted.
      * To generate the password_hash, login to MySQL and run: `select PASSWORD('mypassword');`

* `server/timezone_tables.sls`

    * Populates the mysql timezone tables using the output from the mysql_tzinfo_to_sql command
    * When it executes, writes the output to /tmp/mysql_tzinfo_to_sql.result. If this file already exists, this state will not fire. In other words, if only runs the first time Percona server is deployed on a minion (unless the output file is manually deleted)
    * Managed file:
        * `/tmp/mysql_tzinfo_to_sql.result`

* `server/root.sls`

    * Sets the 'root'@'localhost', 'root'@'127.0.0.1' and 'root'@'::1' passwords
    * Fires only if the saltminion.mysql.user pillar is NOT root
    * Ideally, this runs after the adhoc.percona.initialize state has been ran and the saltadmin user has been created and used in saltminion.mysql


## Dependencies            

* `yumrepos.percona`
* `salt.minion.mysql`


## Version Locks

Note that by default, the `allow_updates` flag is set to True, which means that the declared versions will be installed on first application, but may be manually updated outside of salt. This mechanism has been added for safety. To force the Percona packages to stick to the declared version, set the `allow_updates` pillar to False.

* `Percona-Server-shared-56`
* `Percona-Server-client-56`
* `Percona-Server-server-56`
