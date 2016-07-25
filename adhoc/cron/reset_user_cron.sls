# Reset user cron access permissions by
# deleting /etc/cron.allow and reinstating
# /etc/cron.deny


adhoc-cron-allowfile:
  file.absent:
    - name: /etc/cron.allow

adhoc-cron-denyfile:
  file.managed:
    - name: /etc/cron.deny
    - user: root
    - group: root
    - mode: 600
    - replace: False
