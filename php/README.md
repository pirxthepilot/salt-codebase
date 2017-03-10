# PHP Configuration


## OS Support

* CentOS 6.x
* CentOS 7.x


## State Files

* `init.sls`

    * Ensures standard required PHP packages are installed, and dependencies met
    * Depends on `php_cli`
    * Calls `config.sls`

* `php_cli.sls`

    * Installs the PHP packages php-cli and php-common
    * Can be called standalone for minimal PHP deployments

* `config.sls`

    * Deploys the default PHP ini configuration
    * Managed file:
        * `/etc/php.d/00_defaults.ini` - can be edited by user


## Dependencies            

* `httpd`
* `php`
* `yumrepos.webtatic`


## Version Locks

* `php55w-cli`
* `php55w-common`
* `php55w`
* `php55w-bcmath`
* `php55w-devel`
* `php55w-gd`
* `php55w-imap`
* `php55w-mbstring`
* `php55w-mcrypt`
* `php55w-mysql` or `php55w-mysqlnd`
* `php55w-pdo`
* `php55w-process`
* `php55w-pecl-igbinary`
* `php55w-pecl-imagick`
* `php55w-soap`
* `php55w-xml`
