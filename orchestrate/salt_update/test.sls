{%- import_yaml "orchestrate/salt_update/target.yaml" as target -%}

test_uptime:
  salt.function:
    - tgt: {{ target.tgt }}
    - tgt_type: {{ target.tgt_type }}
    - name: cmd.run
    - arg:
      - uptime
