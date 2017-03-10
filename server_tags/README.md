# Server Tags


## OS Support

* CentOS 5.x
* CentOS 6.x
* CentOS 7.x


## Tag Descriptions

### Manual tags

  | tag                  | values            | description                                   |
  |----------------------|-------------------|-----------------------------------------------|
  | business_criticality | low, medium, high | Impact to business were the server to go down |
  | public               | True, False       | Internet-facing server                        |
  | stable               | True, False       | Server is running with standard configuration |

### Auto tags

  | tag      | values          | description                          |
  |----------|-----------------|------------------------------------- |
  | networks | network-1, etc. | List of networks a server belongs to |
  | os       | centos5, etc.   | OS and major version                 |
  | httpd    | True, False     | HTTPD is installed                   |
  | database | True, False     | MySQL/Percona server is installed    |
  | sso      | True, False     | SSO authentication is enabled        |
  | luks     | True, False     | Contains encrypted partitions        |
  | nfs      | True, False     | Contains NFS mounts                  |


## Notes

* There are no default `server_tags` (manual) pillars - this is by design! Each minion should have its own explicitly set.


## State Files

* `manual.sls`
* `auto.sls`


## Dependencies

* `salt.minion`
