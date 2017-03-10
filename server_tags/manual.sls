# Manually-set server tags
#
# These tags will be applied as grains on each server,
# and configured via pillars
#

{# Tags are first declared here #}
{% set business_criticality = salt['pillar.get']('server_tags:business_criticality') %}
{% set phi = salt['pillar.get']('server_tags:phi', False) %}
{% set public = salt['pillar.get']('server_tags:public', False) %}
{% set stable = salt['pillar.get']('server_tags:stable', False) %}

include:
  - salt.minion

server_tags:manual:
  grains.present:
    - value:
        'business_criticality': {{ business_criticality }}
  {% if public is sameas true %}
        'public': True
  {% endif %}
  {% if stable is sameas true %}
        'stable': True
  {% endif %}
    - force: True
    - require:
      - sls: salt.minion
