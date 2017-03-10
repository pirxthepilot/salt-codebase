# Sudoers

Manages `/etc/sudoers.d` files

## OS Support

* CentOS 6.x
* CentOS 7.x

## Notes

* This state first checks if the declared user or group exists (using `getent`). If it does not, it will not create the file, but the salt run will still show as "clean" (ie. the state will not throw an error).
* If a user or group is removed from the sudoers pillar, the corresponding file in /etc/sudoers.d needs to be removed manually.
