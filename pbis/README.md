# PBIS Configuration


## OS Support

* CentOS 6.x only


## State Files

* `init.sls`

    * Installs the pbis-open package from the pbiso repo
    * Deploys the join script and README in /root
    * Managed files:
        * `/etc/pbis_join.sh`
        * `/etc/pbis.README.txt`
