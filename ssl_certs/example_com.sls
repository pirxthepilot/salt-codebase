{%- import_yaml "ssl_certs/defaults.yaml" as default_settings -%}
{%- set ssl_certs = salt['pillar.get']('ssl_certs', default=default_settings.ssl_certs, merge=True) -%}

include:
  - ssl_certs

ssl-cer-example_com:
  file.managed:
    - name: {{ ssl_certs.dir }}/{{ ssl_certs.example_com.cer_file }}
    - contents_pillar: {{ ssl_certs.example_com.cer_source }}
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: ssl-certs-dir

ssl-key-example_com:
  file.managed:
    - name: {{ ssl_certs.dir }}/{{ ssl_certs.example_com.key_file }}
    - contents_pillar: {{ ssl_certs.example_com.key_source }}
    - user: root
    - group: root
    - mode: 640
    - require:
      - file: ssl-certs-dir
