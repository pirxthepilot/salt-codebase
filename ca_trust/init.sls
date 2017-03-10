{# <CentOS 6 and 7> #}
{%- if grains['os'] == 'CentOS' and (grains['osmajorrelease'] == '7' or grains['osmajorrelease'] == '6') -%}

{%- import_yaml "ca_trust/defaults.yaml" as default_settings -%}
{%- set ca_trust = salt['pillar.get']('ca_trust', default=default_settings.ca_trust, merge=True) -%}
{%- set ca_trust_dir = '/etc/pki/ca-trust/source/anchors' -%}

{%- if ca_trust.certlist -%}


ca-trust-dir:
  file.directory:
    - name: {{ ca_trust_dir }}
    - user: root
    - group: root
    - dir_mode: 755

update-ca-trust:
  cmd.run:
    - name: /usr/bin/update-ca-trust
    - runas: root
    - require:
      - file: ca-trust-dir

  {% if grains['osmajorrelease'] == '6' %}
update-ca-trust-enable:
  cmd.run:
      - name: /usr/bin/update-ca-trust enable
      - runas: root
      - onchanges:
        - cmd: update-ca-trust
  {% endif %}


  {% for caname, params in ca_trust.certlist.items() %}
ca-trust-{{ caname }}:
  file.managed:
    - name: {{ ca_trust_dir }}/{{ params.cer_file }}
    - contents_pillar: {{ params.cer_source }}
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: ca-trust-dir
    - onchanges_in:
      - cmd: update-ca-trust
  {% endfor %}


{% endif %}


{# </CentOS 6 and 7> #}
{%- endif -%}
