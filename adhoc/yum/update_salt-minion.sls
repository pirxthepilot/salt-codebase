# Update minions with the latest Salt version
# and restart
#
# This state needs to be called with a custom
# 'update_to_version' pillar


restart-saltminion:
  cmd.run:
    - name: echo service salt-minion restart | at now + 2 minute
    - runas: root
    - prereq:
      - pkg: salt-updates

salt-updates:
  pkg.installed:
    - pkgs:
      - salt: {{ pillar['update_to_version'] }}
      - salt-minion: {{ pillar['update_to_version'] }}
