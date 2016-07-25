{%- import_yaml "networking/defaults.yaml" as default_settings -%}
{%- set networking = salt['pillar.get']('networking', default=default_settings.networking, merge=True) -%}

#
# Networking options controlled by sysctl
#

# CentOS 6: Ensure sysctl.d exists
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '6' %}
sysctld-dir:
  file.directory:
    - name: /etc/sysctl.d
    - user: root
    - group: root
    - dir_mode: 755
    - require_in:
      - sysctl: net.ipv6.conf.all.disable_ipv6
      - sysctl: net.ipv6.conf.default.disable_ipv6
      - sysctl: net.ipv4.ip_forward
{%- endif %}


# IPv6

{% set sysctl_config_ipv6 = '/etc/sysctl.d/10-salt_ipv6.conf' %}
{% if networking.options.disable_ipv6 is sameas true %}
{% set disable_ipv6_val = 1 %}
{% else %}
{% set disable_ipv6_val = 0 %}
{% endif %}

net.ipv6.conf.all.disable_ipv6:
  sysctl.present:
    - value: {{ disable_ipv6_val }}
    - config: {{ sysctl_config_ipv6 }}

net.ipv6.conf.default.disable_ipv6:
  sysctl.present:
    - value: {{ disable_ipv6_val }}
    - config: {{ sysctl_config_ipv6 }}


# IPv4 Forwarding

{% set sysctl_config_ipfw = '/etc/sysctl.d/10-salt_ip_forward.conf' %}
{% if networking.options.disable_ipv4_forward is sameas true %}
{% set ipv4_forward = 0 %}
{% else %}
{% set ipv4_forward = 1 %}
{% endif %}

net.ipv4.ip_forward:
  sysctl.present:
    - value: {{ ipv4_forward }}
    - config: {{ sysctl_config_ipfw }}
