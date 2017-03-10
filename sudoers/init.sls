{%- import_yaml "sudoers/defaults.yaml" as default_settings -%}
{%- set sudoers = salt['pillar.get']('sudoers', default=default_settings.sudoers, merge=True) -%}

# Manage /etc/sudoers.d contents
#

{%- if sudoers -%}

{% for name, params in sudoers.items() %}

  {% if params.type == 'group' %}
    {% set id = '%' ~ name %}
    {% set getent_arg = 'group' %}
  {% elif params.type == 'user' %}
    {% set id = name %}
    {% set getent_arg = 'passwd' %}
  {% endif %}

sudoers-{{ name }}:
  file.managed:
    - name: /etc/sudoers.d/{{ name|replace(".", "_") }}
    - contents: |
        # sudoers.d entry for {{ name }}
        # Managed by salt - do not modify!
        {{ id }}  {{ params.permissions }}
    - user: root
    - group: root
    - mode: 440
    - onlyif:
      - getent {{ getent_arg }} {{ name }}

{% endfor %}

{%- endif -%}
