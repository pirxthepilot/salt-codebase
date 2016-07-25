# Update minions with the latest Salt version
#

include:
  - salt.minion


salt-minion-update:
  pkg.installed:
    - name: salt
    - watch_in: 
      - service: salt-minion
