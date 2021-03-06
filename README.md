# rest2ldap-cookbook

Installs and configures the OpenDJ Rest2Ldap Gateway in Tomcat

## Supported Platforms

* Ubuntu
  * 14.04

This is a fairly simple cookbook so it will likely work on other Ubuntu versions
as well as RHEL/CentOS platforms.

This allows you to to have a REST interface to an LDAP Directory server.  Currently
tested with the following.

* OpenDJ
* Sun One Directory Server

Given the right configuration it should work with just about any directory server
including Active Directory.

## Tunable Attributes

All tunable attributes are in the `rest2ldap` hierarchy.

Key | Type | Description | Default
:---|:---|:---|:---
`name` | String | Name of the WAR file the cookbook will generate | rest2ldap
`version` | String | Rest2Ldap version to download | 2.6.9
`url` | String | Download URL | Calculated
`ldap_host` | String | LDAP Host | 'ldap.example.com'
`ldap_port` | Numeric | LDAP Port | 389
`ldap_binddn` | String | LDAP Bind DN | 'cn=Directory Manager'
`ldap_bindpw` | String | LDAP Bind Password | empty
`ldap_searchbase` | String | LDAP Search Base | 'ou=people,dc=example,dc=com'
`ldap_searchscope` | String | LDAP Search Scope | 'sub'
`ldap_searchfilter` | String | LDAP Search Filter | '(&(objectClass=person)(uid=%s))'
`mappings` | String | List of URL mappings to create | See attribute example

### Important Note

The mappings look relatively complicated upon first inspection.  The OpenDJ Admin
Guide has an appendix with some pretty good documentation.

http://opendj.forgerock.org/opendj-server/doc/admin-guide/#appendix-rest2ldap

## Usage

### rest2ldap

Installs and configures Rest2Ldap LDAP Gateway.

## Configuration

Set the attributes to work in your environment.

## Known Issues

Can't seem to be able to specify more than one '%s' in the search filter.  So
advanced filters like this don't currently work.

(|(&(objectclass=person)(uid=%s))(&(objectClass=account)(cn=%s)))

## License and Authors

- Author:: Matt Mencel (<mr-mencel@wiu.edu>)

```text
Copyright:: 2014 Matt Mencel

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
