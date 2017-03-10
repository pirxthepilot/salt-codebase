# Ensure xinetd is installed and running

xinetd:
  pkg.installed:
    - watch_in:
      - service: xinetd
  service.running:
    - enable: True
