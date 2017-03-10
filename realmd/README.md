# Realmd Configuration


## OS Support

* CentOS 7.x only


## State Files

* `init.sls`

    * Ensures `realmd` is installed and running
    * Ensures other related packages and services are installed and running (e.g. `sssd`)
    * Provides a `realmd.README.txt` in the root homedir for a quick usage guide
    * Deploys the default realmd and sssd settings
    * Managed files:
        * `/etc/realmd.conf`
        * `/etc/sssd/sssd.conf`
