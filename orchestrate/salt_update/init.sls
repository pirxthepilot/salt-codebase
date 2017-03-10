{%- import_yaml "orchestrate/salt_update/target.yaml" as target -%}
# Update salt packages to latest version
#
salt_update:
  salt.state:
    - tgt: {{ target.tgt }}
    - tgt_type: {{ target.tgt_type }}
    - sls:
      - orchestrate.salt_update.update
