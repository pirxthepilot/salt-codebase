# OpenSSH Configuration

Sets `sshd_config` and `ssh_config` options. Default configuration is based on *CentOS 6 and 7 CIS benchmarks* (https://cisecurity.org) and the *Mozilla Security Guidelines wiki* (https://wiki.mozilla.org/Security/Guidelines/OpenSSH)


## IMPORTANT NOTES ##

* Test `sshd_config` options on both CentOS 6 and CentOS 7 thoroughly! Set per-version parameters (`grains['osmajorrelease']`) if necessary.
* Remember, the state files themselves do not check whether an `sshd_config` options or values are supported by an OpenSSH version (CentOS 6 vs CentOS 7). These checks should be performed in `defaults.yaml`, and by extension, on custom pillars.


## OS Support

* CentOS 6.x
* CentOS 7.x


## State Files

* `init.sls`

    * Ensures `openssh-server` is installed and latest, and `sshd` is running
    * Extends the `sshd_config` state
    * Files managed:
        * `/etc/ssh/sshd_config`
        * `/etc/ssh/ssh_config`


## Dependencies

* `openssh-formula` (https://github.com/saltstack-formulas/openssh-formula/)

* `realmd/defaults.yaml`
    * Referenced on `files/sshd_config_custom.jinja`
