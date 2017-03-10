# PHP Tools

Installs and configures various PHP support tools


## OS Support

* CentOS 6 (composer only)
* CentOS 7


## State Files

* `composer.sls`

    * Installs the composer script from the local repo
    * Managed file:
        * `/usr/local/bin/composer`

* `phpcs.sls`

    * Installs PHP_CodeSniffer from the official git repo
    * Version is locked according to what is set in `settings.yaml`


## Dependencies

* `php`
* `php.php_cli`
