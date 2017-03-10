# Salt Ad Hoc States


## cron

### reset_user_cron

  * Reset user cron access permissions by deleting `/etc/cron.allow` and reinstating `/etc/cron.deny`


## yum

### deploy_php-mysqlnd

  * Replaces php-mysql with php-mysqlnd
  * If install succeeds, restart httpd

### update_imagemagick

  * Update ImageMagick to latest

### update_glibc

  * Update glibc to latest, and restart sshd and sssd

### update_salt-minion

  * Update salt-minion to latest and restart the service using at

### update_mysql

  * Update Percona server, mariadb-server or mysql-server to latest
  * Updates automatically restart the mysqld service

### update_openssl

  * Update OpenSSL to latest

### update_kernel

  * Update kernel to specified version (OS-specific)
  * Pillar option to initiate a reboot right after a successful update


## percona

### initialize 

  * Creates the 'saltadmin'@'localhost' mysql user
  * Performs default database configuration/hardening, such as the removal of the test database and anonymous users
  * It is recommended that this is run this the first time Percona is installed on a minion
  * Requires:
    * salt.minion.mysql
    * percona.server


## httpd 

### get_vhost_list
