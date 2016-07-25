{%- import_yaml "accounts/defaults.yaml" as default_settings -%}
{%- set custom_groups = salt['pillar.get']('custom_groups', default=default_settings.custom_groups, merge=True) -%}

{%- if custom_groups -%}

{% for group, params in custom_groups.items() %}
group-{{ group }}:
  group.present:
    - name: {{ group }}
    - system: {{ params.system }}
{% endfor %}

{%- endif -%}
