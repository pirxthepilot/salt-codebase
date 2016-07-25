{%- import_yaml "cis/defaults.yaml" as default_settings -%}
{%- set cis = salt['pillar.get']('cis', default=default_settings.cis, merge=True) -%}

# CIS Hardening
# System file permissions
#

# Note: Disabling CIS hardening will only remove the
# states, and will not roll back file or dir permissions

{% if cis.enable_cis_hardening == True %}

cis-file-passwd:
  file.managed:
    - name: /etc/passwd
    - user: root
    - group: root
    - mode: 644
    - replace: False

cis-file-shadow:
  file.managed:
    - name: /etc/shadow
    - user: root
    - group: root
    - mode: '000'
    - replace: False

cis-file-gshadow:
  file.managed:
    - name: /etc/gshadow
    - user: root
    - group: root
    - mode: '000'
    - replace: False

cis-file-group:
  file.managed:
    - name: /etc/group
    - user: root
    - group: root
    - mode: 644
    - replace: False

{# CentOS 7 only #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7' -%}
cis-file-grub:
  file.managed:
    - name: /boot/grub2/grub.cfg
    - user: root
    - group: root
    - mode: 600
    - replace: False
{%- endif -%}

{% endif %}
