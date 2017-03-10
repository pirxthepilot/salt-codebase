# Check_MK Deployment and Configuration 


## OS Support

* CentOS 5.x
* CentOS 6.x
* CentOS 7.x


## State Files

* `agent.sls`

    * Ensures the check-mk-agent package, and xinetd is running
    * Configures the Check_MK agent
    * Includes the `mrpe` state (Note: Will only fire if the mrpe.config pillar exists)
    * Managed file:
        * `/etc/xinetd.d/check-mk-agent` (line replace only)

* `mrpe.sls`

    * Sets the MRPE configuration for each minion, if the mrpe.config pillar exists
    * By default, MRPE values are not set
    * Managed file:
        * `/etc/check-mk-agent/mrpe.cfg`

* `mrpe_percona.sls`

    * Installs the percona-nagios-plugins package (requires the percona yum repo)
    * Managed file:
        * `/etc/nagios/mysql.cnf` (can be edited manually)


## Dependencies

* `yumrepos.percona`
