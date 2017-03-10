#!py
# vim: syntax=python ts=4 softtabstop=4 sw=4 tw=79 expandtab autoindent fileformat=unix

# Automatic server tags
# Calculated based on existing grains, etc.
#


def _file_exists(path):
    if __salt__['file.file_exists'](path):
        return True
    else:
        return False

def _is_installed(package):
    if __salt__['cmd.retcode']('rpm -q ' + package) == 0:
        return True
    else:
        return False


def run():
    # Init
    config = {}
    grains = {}

    # Includes and requires
    config['include'] = ['salt.minion']
    required = [{'sls': 'salt.minion'}]


    # OS tag
    grains['os'] = __grains__['os'].lower() + str(__grains__['osrelease_info'][0])


    # Network labels
    netmap = {
        '10.0.0.0/24':    'network-1',
        '192.160.0.0/24': 'network-2',
    }

    netlabels = []
    for subnet, label in netmap.items():
        if __salt__['network.in_subnet'](subnet):
            netlabels.append(label)
    grains['networks'] = netlabels


    # Tag based on existence of files
    # E.g. Determines if httpd/mysql server is installed
    tag_by_file = {
        'httpd':    '/usr/sbin/httpd',
        'database': '/usr/bin/mysqld_safe',
    }

    for tagname, path in tag_by_file.iteritems():
        if _file_exists(path):
            grains[tagname] = True

    # SSO tag
    # CentOS 6 - Use domainjoin-cli to check (pbis)
    # CentOS 7 - Use realm to check (realmd)
    if __grains__['osmajorrelease'] == '6' and _file_exists('/usr/bin/domainjoin-cli'):
        if 'Distinguished Name' in __salt__['cmd.run']('domainjoin-cli query'):
            grains['sso'] = True
    elif __grains__['osmajorrelease'] == '7' and _file_exists('/sbin/realm'):
        if 'domain-name' in __salt__['cmd.run']('realm list'):
            grains['sso'] = True


    # NFS tag
    if __salt__['cmd.run']('mount -l -t nfs'):
        grains['nfs'] = True


    # LUKS (encrypted filesystem) tag
    if __salt__['cmd.run']('dmsetup ls --target crypt'):
        grains['luks'] = True


    # Populate the grains.present state
    config['server_tags:auto'] = {
        'grains.present': [
            {'value': grains},
            {'force': True},
            {'require': required},
        ]
    }

    return config
