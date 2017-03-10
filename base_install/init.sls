{# CentOS 6 and 7 support only #}
{%- if grains['os'] == 'CentOS' and (grains['osmajorrelease'] == '6' or grains['osmajorrelease'] == '7') -%}


# Base Packages
# NOTE: Before adding packages here, ensure compatibility
# with CentOS 6 and 7, and use conditionals if needed.

include:
  - yumrepos.centos
  - yumrepos.epel

base-packages:
  pkg.installed:
    - require:
      - sls: yumrepos.centos
      - sls: yumrepos.epel
    - allow_updates: True
    - pkgs:
      - acl
      - at
      - bash-completion
      - bzip2
      - cronie-anacron
      - crontabs
      - curl
      - ed
      - git
      - links
      - lsof
      - mailx
      - man-pages
      - nano
      - net-tools
      - policycoreutils
      - policycoreutils-python
      - psmisc
      - screen
      - sed
      - srm
      - strace
      - sysstat
      - telnet
      - tree
      - vim-enhanced
      - wget
      - yum-plugin-versionlock
      - yum-utils
  {# CentOS 7-specific #}
  {%- if grains['osmajorrelease'] == '7' %}
      - man-db
  {%- endif -%}
  {# CentOS 6-specific #}
  {%- if grains['osmajorrelease'] == '6' %}
      - man
      - yum-plugin-security
  {%- endif -%}


{%- endif -%}
