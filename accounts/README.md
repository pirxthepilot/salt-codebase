# Accounts 

Creation and maintenance of custom users and groups


## OS Support

* CentOS 5.x
* CentOS 6.x
* CentOS 7.x


## State Files

* `init.sls`

    * Calls on `groups.sls` and `users.sls`

* `groups.sls`

    * Ensures that stated groups exist

* `users.sls`

    * Ensures that stated users exist
    * Each user may be a member of one or more groups
    * Each user may have an `authorized_keys` entry that points to a file in `pillar_files` as a `contents_pillar` value (e.g. 'accounts:user.pub')
    * When `password_from_pillar_files` is set to True, the password hash is fetched from a file `pillar_files` as `pillar['accounts']['user.sha512']`
