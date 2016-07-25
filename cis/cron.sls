{%- import_yaml "cis/defaults.yaml" as default_settings -%}
{%- set cis = salt['pillar.get']('cis', default=default_settings.cis, merge=True) -%}

# CIS Hardening
# cron stuff
#

# Note: Disabling CIS hardening will only remove
# the states, and will not roll back files or dirs

{% if cis.enable_cis_hardening == True %}

cis-crond:
  pkg.installed:
    - name: cronie
  service.running:
    - name: crond
    - enable: True

cis-anacrontab:
  file.managed:
    - name: /etc/anacrontab
    - user: root
    - group: root
    - mode: 600
    - replace: False

cis-crontab:
  file.managed:
    - name: /etc/crontab
    - user: root
    - group: root
    - mode: 600
    - replace: False

cis-cron-hourly:
  file.directory:
    - name: /etc/cron.hourly
    - user: root
    - group: root
    - mode: 700
    - replace: False

cis-cron-daily:
  file.directory:
    - name: /etc/cron.daily
    - user: root
    - group: root
    - mode: 700
    - replace: False

cis-cron-weekly:
  file.directory:
    - name: /etc/cron.weekly
    - user: root
    - group: root
    - mode: 700
    - replace: False

cis-cron-monthly:
  file.directory:
    - name: /etc/cron.monthly
    - user: root
    - group: root
    - mode: 700
    - replace: False

cis-cron-d:
  file.directory:
    - name: /etc/cron.d
    - user: root
    - group: root
    - mode: 700

{% if cis.cron.force_cron_allow is sameas true %}
cis-cron-deny:
  file.absent:
    - name: /etc/cron.deny

cis-cron-allow:
  file.managed:
    - name: /etc/cron.allow
    - user: root
    - group: root
    - mode: 600
    - replace: False
{% endif %}

{% if cis.cron.force_at_allow is sameas true %}
cis-at-deny:
  file.absent:
    - name: /etc/at.deny

cis-at-allow:
  file.managed:
    - name: /etc/at.allow
    - user: root
    - group: root
    - mode: 600
    - replace: False
{% endif %}

{% endif %}
