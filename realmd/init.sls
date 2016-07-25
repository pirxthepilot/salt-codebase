{# <CentOS 7> #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7'-%}


{%- import_yaml "realmd/defaults.yaml" as default_settings -%}
{%- set realmd = salt['pillar.get']('realmd', default=default_settings.realmd, merge=True) -%}
# Realmd Configuration
# For Active Directory integration


realmd-install:
  pkg.installed:
    - pkgs:
      - realmd
      - sssd
      - oddjob
      - oddjob-mkhomedir
      - samba-common
      - adcli

realmd-restart:
  cmd.wait:
    - name: /sbin/systemctl restart realmd
    - user: root

realmd-config:
  file.managed:
    - name: /etc/realmd.conf
    - source: salt://realmd/files/realmd.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: realmd-restart

realmd-readme:
  file.managed:
    - name: /root/realmd.README.txt
    - source: salt://realmd/files/realmd.README.txt.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 640
    - require:
      - pkg: realmd-install

# Ensure sssd and sudoers is running and configured only
# after minion has been joined to AD
{% if salt['file.file_exists']('/sbin/realm') %}
{% if salt['cmd.run']('/sbin/realm list --name-only') %}

sssd:
  service.running:
    - enable: True
    - require:
      - pkg: realmd-install

# sssd.conf tweak to disable fully qualified names
{% if realmd.use_fully_qualified_names == False -%}
realmd-disable-fqn:
  file.replace:
    - name: /etc/sssd/sssd.conf
    - pattern: ^use_fully_qualified_names\s*=\s*[Tt]rue
    - repl: use_fully_qualified_names = False
    - watch_in:
      - service: sssd
{% endif -%}

# AD sudoers
# Note that GROUPS added here are also added to
# AllowGroups in sshd_config via the openssh states

realmd-sudoers-ad:
  file.managed:
    - name: /etc/sudoers.d/realm_sudoers
    - source: salt://realmd/files/realm_sudoers.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 640
    - require:
      - pkg: realmd-install

# Nagios sudoers

#realmd-sudoers-nagios:
#  file.managed:
#    - name: /etc/sudoers.d/nagios
#    - source: salt://realmd/files/nagios_sudoers
#    - user: root
#    - group: root
#    - require:
#      - pkg: realmd-install

{% endif %}
{% endif %}
# End is_joined_to_ad


{# </CentOS 7> #}
{%- endif -%}
