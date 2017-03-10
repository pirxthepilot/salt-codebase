# Update salt, then restart salt-minion

salt:
  pkg.latest:
    - watch_in:
        - service: salt-minion

salt-minion:
  service.running
