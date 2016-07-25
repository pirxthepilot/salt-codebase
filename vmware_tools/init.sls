# Install open-vm-tools on VMware VMs only
#

{# If CentOS 6, require EPEL #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '6' -%}
include:
  - yumrepos.epel
{%- endif -%}


{% if 'VMware' in grains["manufacturer"] %}
open-vm-tools:
  pkg.installed: []
  service.running:
    - name: vmtoolsd
    - enable: True
  {%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '6' %}
    - require:
      - pkg: epel-release
  {%- endif -%}
{% endif %}
