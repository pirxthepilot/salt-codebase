# Networking Configuration


## OS Support

* CentOS 6.x
* CentOS 7.x


## State Files

* `init.sls`

    * Simply calls the various networking states in this category

* `options.sls`

    * Adjusts various networking options:
        * Enable/disable IPv6 entirely
        * Enable/disable IPv4 forwarding
    * Managed files:
        * `/etc/sysctl.d/10-salt_ipv6.conf`
        * `/etc/sysctl.d/10-salt_ip_forward.conf`
