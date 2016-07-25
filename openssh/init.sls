{% from "openssh/map.jinja" import openssh with context %}

openssh:
  {% if openssh.server is defined %}
  pkg.latest:
    - name: {{ openssh.server }}
  {% endif %}
  service.running:
    - enable: True
    - name: {{ openssh.service }}
  {% if openssh.server is defined %}
    - watch:
      - pkg: {{ openssh.server }}
  {% endif %}

include:
  - openssh.config
  - openssh.banner


# Extend sshd_config
extend:
  sshd_config:
    file.managed:
      - mode: 600
