{%- import_yaml "orchestrate/ssh_key/settings.yaml" as setting -%}
{% set user = salt['pillar.get']('user') %}

add_ssh_keys:
  cmd.run:
    - name: ssh-keygen -q -N '' -f {{ setting.key_file }}
    - unless: test -f {{ setting.key_file }}
    - user: {{ user }}
