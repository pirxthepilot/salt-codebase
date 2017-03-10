{%- import_yaml "cis/paths.yaml" as paths -%}
{%- import_yaml "cis/defaults.yaml" as default_settings -%}
{%- set cis = salt['pillar.get']('cis', default=default_settings.cis, merge=True) -%}

# CIS Hardening
# Auditd Configuration
#

include:
  - cis.system_files

auditd:
  service.running:
    - enable: True

# Custom audit restart state ('systemctl restart auditd' is not allowed by OS)
auditd-restart:
  cmd.wait:
    - name: /sbin/service auditd restart
    - runas: root


# Note: Disabling CIS hardening will only remove
# the *.rules files and reload auditd

{% if cis.enable_cis_hardening == True %}

# Enable augenrules option in CentOS 6
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '6' -%}
auditd-augenrules:
  file.replace:
    - name: /etc/sysconfig/auditd
    - pattern: ^#?USE_AUGENRULES.+$
    - repl: USE_AUGENRULES="yes"
    - append_if_not_found: True
    - watch_in:
      - cmd: auditd-restart
    - require_in:
      - file: auditd-config
      - cmd: auditd-cis-custom
      - file: auditd-cis-fixed
      - file: auditd-misc
{%- endif %}

auditd-config:
  file.managed:
    - name: {{ paths.auditd.config_file }}
    - template: jinja
    - source: {{ paths.auditd.config_source }}
    - user: root
    - group: root
    - mode: 640
    - watch_in:
      - cmd: auditd-restart

auditd-cis-custom:
  cmd.script:
    - source: {{ paths.auditd.cis_custom_script }}
    - template: jinja
    - runas: root
    - creates: {{ paths.auditd.cis_custom_file }}
    - watch_in:
      - cmd: auditd-restart

auditd-cis-fixed:
  file.managed:
    - name: {{ paths.auditd.cis_fixed_file }}
    - source: {{ paths.auditd.cis_fixed_source }}
    - user: root
    - group: root
    - mode: 640
    - watch_in:
      - cmd: auditd-restart

auditd-misc:
  file.managed:
    - name: {{ paths.auditd.misc_file }}
    - source: {{ paths.auditd.misc_source }}
    - user: root
    - group: root
    - mode: 640
    - watch_in:
      - cmd: auditd-restart


{# CentOS 7 only #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7' -%}

auditd-grub-check:
  cmd.run:
    - name: |
        /bin/grep -q "audit=1" {{ paths.auditd.grub_defaults_file }}
        if [ "$?" -eq 0 ]; then echo "changed=no comment='Grub audit enabled'"; else echo "changed=yes comment='Grub audit disabled'"; fi
    - stateful: True
    - runas: root

auditd-grub-mod:
  file.replace:
    - name: {{ paths.auditd.grub_defaults_file }}
    - pattern: |
        (GRUB_CMDLINE_LINUX=".*)"
    - repl: |
        \1 audit=1"
    - backup: '.old'
    - show_changes: True
    - onchanges:
      - cmd: auditd-grub-check

auditd-grub-reload:
  cmd.wait:
    - name: /usr/sbin/grub2-mkconfig -o /boot/grub2/grub.cfg
    - runas: root
    - watch:
      - file: auditd-grub-mod
    - watch_in:
      - file: cis-file-grub

{%- endif -%}


{% else %}

auditd-cis-custom:
  file.absent:
    - name: {{ paths.auditd.cis_custom_file }}
    - watch_in:
      - cmd: auditd-restart

auditd-cis-fixed:
  file.absent:
    - name: {{ paths.auditd.cis_fixed_file }}
    - watch_in:
      - cmd: auditd-restart

auditd-misc:
  file.absent:
    - name: {{ paths.auditd.misc_file }}
    - watch_in:
      - cmd: auditd-restart

{% endif %}
