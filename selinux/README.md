# SELinux


## OS Support

* CentOS 6.x
* CentOS 7.x


## State Files

* `init.sls`

    * Sets the SELinux mode (either Enforcing, Permissive or Disabled)
    * Ensures the set mode is persistent after reboots


## Dependencies

* `base_install`
