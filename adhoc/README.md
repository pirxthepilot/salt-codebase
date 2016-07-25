# Salt Ad Hoc States


## cron

### adhoc.cron.reset_user_cron

  * Reset user cron access permissions by deleting `/etc/cron.allow` and reinstating `/etc/cron.deny`


## yum

### adhoc.yum.update_imagemagick

  * Update ImageMagick to latest

### adhoc.yum.update_glibc

  * Update glibc to latest, and restart sshd and sssd
