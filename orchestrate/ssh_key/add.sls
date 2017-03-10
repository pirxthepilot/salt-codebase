{% set host = salt['pillar.get']('host') %}
{% set user = salt['pillar.get']('user') %}

salt_update:
  salt.state:
    - tgt: {{ host }}
    - pillar: {{ pillar|json() }}
    - sls:
      - orchestrate.ssh_key.add_function
