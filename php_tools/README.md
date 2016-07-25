# PHP Tools

Installs and configures various PHP support tools


## OS Support

* CentOS 7 only


## State Files

* `composer.sls`

    * Installs the composer script from the local salt:// repo
    * Managed file:
        * `/usr/local/bin/composer`

* `twig.sls`

    * Installs Twig via pear

* `phpcs.sls`

    * Installs PHP_CodeSniffer from the official git repo
    * Version is locked according to what is set in `settings.yaml`


## Dependencies

* `php`
