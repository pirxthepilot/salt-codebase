{%- import_yaml "ssl_certs/defaults.yaml" as default_settings -%}
{%- set ssl_certs = salt['pillar.get']('ssl_certs', default=default_settings.ssl_certs, merge=True) -%}


{%- if ssl_certs.custom -%}

include:
  - ssl_certs

{% for certname, params in ssl_certs.custom.items() %}

ssl-cer-{{ certname }}:
  file.managed:
    - name: {{ ssl_certs.dir }}/{{ params.cer_file }}
    - contents_pillar: {{ params.cer_source }}
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: ssl-certs-dir

ssl-key-{{ certname }}:
  file.managed:
    - name: {{ ssl_certs.dir }}/{{ params.key_file }}
    - contents_pillar: {{ params.key_source }}
    - user: root
    - group: root
    - mode: 640
    - require:
      - file: ssl-certs-dir

{% endfor %}

{% endif %}
