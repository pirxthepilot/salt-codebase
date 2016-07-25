{%- import_yaml "adhoc/accounts/userlist.yaml" as userlist -%}
{%- set users = userlist.users -%}

include:
  - accounts.users

{% for user, params in users.items() %}

Setting password for {{ user }}:
  user.present:
    - name: {{ user }}
    - password: {{ params.password }}
    - remove_groups: False
    - require:
      - user: user-{{ user }}

{% endfor %}
