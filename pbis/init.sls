{# <CentOS 6> #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '6'-%}


{%- import_yaml "pbis/defaults.yaml" as default_settings -%}
{%- set pbis = salt['pillar.get']('pbis', default=default_settings.pbis, merge=True) -%}

{%- set pbis_installer_path = '/root/pbis64' -%}

# PBIS Configuration
# For Active Directory integration

include:
  - yumrepos.pbiso


pbis-open:
  {%- if pbis.always_latest is sameas true %}
  pkg.latest:
  {% else %}
  pkg.installed:
  {% endif -%}
    - require:
      - pkgrepo: pbiso

lwsmd:
  service.running:
    - require:
      - pkg: pbis-open

pbis-join-script:
  file.managed:
    - name: /root/pbis_join.sh
    - source: salt://pbis/files/pbis_join.sh.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 750
    - require:
      - pkg: pbis-open

pbis-readme:
  file.managed:
    - name: /root/pbis.README.txt
    - source: salt://pbis/files/pbis.README.txt
    - user: root
    - group: root
    - mode: 640
    - require:
      - pkg: pbis-open


{# </CentOS 6> #}
{%- endif -%}
