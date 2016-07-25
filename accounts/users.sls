{%- import_yaml "accounts/defaults.yaml" as default_settings -%}
{%- set custom_users = salt['pillar.get']('custom_users', default=default_settings.custom_users, merge=True) -%}


{%- if custom_users -%}

include:
  - accounts.groups

{% for user, params in custom_users.items() %}

user-{{ user }}:
  user.present:
    - name: {{ user }}
    - shell: /bin/bash
    - system: {{ params.system }}
    - groups: {{ params.groups }}
    - remove_groups: {{ params.remove_groups }}
  # Get password from pillar_files
  {% if params.password_from_pillar_files is sameas true %}
    - password: {{ pillar['accounts'][user ~ '.sha512'] }}
    - enforce_password: True
  {% endif %}
    - require:
      - sls: accounts.groups

  {% if params.authorized_key is defined %}

# NOTE: This is a workaround until contents_pillar is
#       implemented on "ssh_auth.present"
#       See https://github.com/saltstack/salt/issues/34231
authorized_key-{{ user }}:
  file.managed:
    - name: /home/{{ user }}/.ssh/authorized_keys
    - contents_pillar: {{ params.authorized_key }}
    - user: {{ user }}
    - group: {{ user }}
    - mode: 600
    - makedirs: True
    - require:
      - user: user-{{ user }}

#authorized_key-{{ user }}:
#  ssh_auth.present:
#    - user: {{ user }}
#    #- name: {{ pillar['accounts'][user ~ '.pub'] }}

  {% endif %}

{% endfor %}

{%- endif -%}
