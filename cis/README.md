# CIS CentOS Linux 7 Benchmark v1.1.0

Hardening configuration based on CIS benchmarks


## OS Support

See individual state files below


## State Files

* `init.sls`

    * Loads the sls files in this category

* `auditd.sls`

    * Auditd configurations
    * OS support: CentOS 6 and 7
    * Managed files:
        * `/etc/audit/auditd.conf`
        * `/etc/audit/rules.d/cis_custom.rules`
        * `/etc/audit/rules.d/cis_fixed.rules`
        * `/etc/audit/rules.d/misc.rules`
        * `/etc/audit/rules.d`
        * `/etc/default/grub` (line replace only)

* `coredumps.sls`

    * Restrict core dumps
    * OS support: CentOS 6 and 7
    * Managed file:
        * `/etc/security/limits.d/00-cis_coredumps.conf`

* `cron.sls`

    * Ensure `crond` is running
    * Ensure existence and absence of certain files
        * Forcing the use of of `/etc/cron.allow` or `/etc/at.allow` can be turned on or off
    * Adjust permissions
    * OS support: CentOS 6 and 7

* `disallowed_packages.sls`

    * Ensure yum packages in the list are NOT installed
    * OS support: CentOS 6 and 7

* `modprobe.sls`

    * Disable mounting of certain filesystems
    * Disallow uncommon network protocols
    * OS support: CentOS 6 and 7
    * Managed files:
        * `/etc/modprobe.d/cis_blacklist_filesystems.conf`
        * `/etc/modprobe.d/cis_uncommon_protocols.conf`

* `rsyslog.sls`

    * Ensure `rsyslog` is installed and running
    * OS support: CentOS 6 and 7

* `sysctl.sls`

    * Set network hardening options
    * Kernel and core dump options
    * OS support: CentOS 6 and 7
    * Managed file:
        * `/etc/sysctl.d/98-salt_cis.conf`

* `system_files.sls`

    * Adjust permissions of certain system files
    * OS support: CentOS 6 and 7

* `umask.sls` (currently disabled)

    * Adjust umask of daemons
    * OS support: CentOS 7 only

* `yum.sls`

    * Ensure that yum gpgcheck is enabled
    * OS support: CentOS 6 and 7


*****

## Status Summary

1 Install Updates, Patches and Additional Security Software    | |
-------------------------------------------------------------- | --------------------
    1.1 Filesystem Configuration                               |
    1.2 Configure Software Updates                             |
    1.3 Advanced Intrusion Detection Environment (AIDE)        |
    1.4 Configure SELinux                                      | DONE; Permissive by default
    1.5 Secure Boot Settings                                   | DONE
    1.6 Additional Process Hardening                           | DONE

2 OS Services                                                  | |
-------------------------------------------------------------- | --------------------
    2.1 Remove Legacy Services                                 | DONE
    2.1 Remove Legacy Services                                 | DONE

3 Special Purpose Services                                     | DONE
-------------------------------------------------------------- | --------------------

4 Network Configuration and Firewalls                          | |
-------------------------------------------------------------- | --------------------
    4.1 Modify Network Parameters (Host Only)                  | DONE
    4.2 Modify Network Parameters (Host and Router)            | DONE
    4.3 Wireless Networking                                    | N/A
    4.4 IPv6                                                   | DONE (see `networking`)
    4.5 Install TCP Wrappers                                   |
    4.6 Uncommon Network Protocols                             | DONE
    4.7 Enable firewalld                                       |

5 Logging and Auditing                                         | |
-------------------------------------------------------------- | --------------------
    5.1 Configure rsyslog                                      | DONE
    5.2 Configure System Accounting (auditd)                   | DONE

6 System Access, Authentication and Authorization              | |
-------------------------------------------------------------- | --------------------
    6.1 Configure cron and anacron                             | DONE
    6.2 Configure SSH                                          | DONE (see `openssh`);  PermitRootLogin yes by default; ClientAliveInterval 0 by default
    6.3 Configure PAM                                          |

7 User Accounts and Environment                                | |
-------------------------------------------------------------- | --------------------
    7.1 Set Shadow Password Suite Parameters (/etc/login.defs) |

8 Warning Banners                                              | DONE
-------------------------------------------------------------- | --------------------

9 System Maintenance                                           | |
-------------------------------------------------------------- | --------------------
    9.1 Verify System File Permissions                         | PARTIAL
    9.2 Review User and Group Settings                         |
