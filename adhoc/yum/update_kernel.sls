# Update kernel to latest
#
# To include the reboot right after the kernel update, run
# the usual state.apply with
#     pillar='{ "reboot": true }'
#
# To manually reboot a server, run
#     salt minion_id system.reboot (at_time=minutes)


# Explicitly define the kernel version to update to
# Latest as of 03/06/2017
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7'-%}
  {%- set kernel_version = '3.10.0-514.6.2.el7' -%}
{%- elif grains['os'] == 'CentOS' and grains['osmajorrelease'] == '6'-%}
  {%- set kernel_version = '2.6.32-642.13.2.el6' -%}
{%- elif grains['os'] == 'CentOS' and grains['osmajorrelease'] == '5'-%}
  {%- set kernel_version = '2.6.18-419.el5' -%}
{%- endif %}


kernel-{{ kernel_version }}:
  pkg.installed:
    - name: kernel
    - version: {{ kernel_version }}

kernel-tools-{{ kernel_version }}:
  pkg.installed:
    - name: kernel-tools
    - version: {{ kernel_version }}
    - onlyif: rpm -q kernel-tools
    - require:
      - pkg: kernel-{{ kernel_version }}

# Auto-reboot only if explicitly specified
{% if salt['pillar.get']('reboot') is sameas true %}
reboot:
  module.run:
    - name: system.reboot
    - at_time: 1
    - onchanges:
      - pkg: kernel-{{ kernel_version }}
    - require:
      - pkg: kernel-tools-{{ kernel_version }}
{% endif -%}
