default[:rest2ldap][:version] = '2.6.9'
url = 'http://maven.forgerock.org/repo/releases/org/forgerock/opendj'\
'/opendj-rest2ldap-servlet/' + node[:rest2ldap][:version] + '/'\
'opendj-rest2ldap-servlet-' + node[:rest2ldap][:version] + '-'\
'servlet.war'
default[:rest2ldap][:url] = url

default[:rest2ldap][:ldap_host] = 'ldap.example.com'
default[:rest2ldap][:ldap_port] = 389
default[:rest2ldap][:ldap_binddn] = 'cn=Directory Manager'
default[:rest2ldap][:ldap_bindpw] = 'password'
default[:rest2ldap][:ldap_searchbase] = 'ou=people,dc=example,dc=com'
default[:rest2ldap][:ldap_searchscope] = 'sub' # sub OR one
default[:rest2ldap][:ldap_searchfilter] = '(&(objectClass=person)(uid=%s))'

mappings <<-EOS
"/users" : {
  "baseDN"              : "ou=people,dc=example,dc=com",
  "readOnUpdatePolicy"  : "controls",
  "useSubtreeDelete"    : false,
  "usePermissiveModify" : true,
  "etagAttribute"       : "etag",
  "namingStrategy"      : {
    "strategy"    : "clientDNNaming",
    "dnAttribute" : "uid"
  },
  "additionalLDAPAttributes" : [
    {
      "type" : "objectClass",
      "values" : [
        "top",
        "person",
        "organizationalPerson",
        "inetOrgPerson"
      ]
    }
  ],
  "attributes" : {
    "schemas"     : { "constant" : [ "urn:scim:schemas:core:1.0" ] },
    "_id"         : { "simple"   : { "ldapAttribute" : "uid", "isSingleValued" : true, "isRequired" : true, "writability" : "createOnly" } },
    "_rev"        : { "simple"   : { "ldapAttribute" : "etag", "isSingleValued" : true, "writability" : "readOnly" } },
    "userName"    : { "simple"   : { "ldapAttribute" : "mail", "isSingleValued" : true, "writability" : "readOnly" } },
    "displayName" : { "simple"   : { "ldapAttribute" : "cn", "isSingleValued" : true, "isRequired" : true } },
    "name"        : { "object"   : {
      "givenName"  : { "simple" : { "ldapAttribute" : "givenName", "isSingleValued" : true } },
      "familyName" : { "simple" : { "ldapAttribute" : "sn", "isSingleValued" : true, "isRequired" : true } }
    } },
    "manager"     : { "reference" : {
      "ldapAttribute" : "manager",
      "baseDN"        : "ou=people,dc=example,dc=com",
      "primaryKey"    : "uid",
      "mapper"         : { "object" : {
        "_id"         : { "simple"   : { "ldapAttribute" : "uid", "isSingleValued" : true, "isRequired" : true } },
        "displayName" : { "simple"   : { "ldapAttribute" : "cn", "isSingleValued" : true, "writability" : "readOnlyDiscardWrites" } }
      } }
    } },
    "groups"     : { "reference" : {
      "ldapAttribute" : "isMemberOf",
      "baseDN"        : "ou=groups,dc=example,dc=com",
      "writability"   : "readOnly",
      "primaryKey"    : "cn",
      "mapper"        : { "object" : {
        "_id"         : { "simple"   : { "ldapAttribute" : "cn", "isSingleValued" : true } }
        } }
        } },
        "contactInformation" : { "object" : {
          "telephoneNumber" : { "simple" : { "ldapAttribute" : "telephoneNumber", "isSingleValued" : true } },
          "emailAddress"    : { "simple" : { "ldapAttribute" : "mail", "isSingleValued" : true } }
        } },
          "meta"        : { "object" : {
            "created"      : { "simple" : { "ldapAttribute" : "createTimestamp", "isSingleValued" : true, "writability" : "readOnly" } },
            "lastModified" : { "simple" : { "ldapAttribute" : "modifyTimestamp", "isSingleValued" : true, "writability" : "readOnly" } }
          } }
      }
    },
"/groups" : {
  "baseDN"              : "ou=groups,dc=example,dc=com",
  "readOnUpdatePolicy"  : "controls",
  "useSubtreeDelete"    : false,
  "usePermissiveModify" : true,
  "etagAttribute"       : "etag",
  "namingStrategy"      : {
    "strategy"    : "clientDNNaming",
    "dnAttribute" : "cn"
  },
  "additionalLDAPAttributes" : [
    {
      "type" : "objectClass",
      "values" : [
        "top",
        "groupOfUniqueNames"
      ]
    }
  ],
  "attributes" : {
    "schemas"     : { "constant" : [ "urn:scim:schemas:core:1.0" ] },
    "_id"         : { "simple"   : { "ldapAttribute" : "cn", "isSingleValued" : true, "isRequired" : true, "writability" : "createOnly" } },
    "_rev"        : { "simple"   : { "ldapAttribute" : "etag", "isSingleValued" : true, "writability" : "readOnly" } },
    "displayName" : { "simple"   : { "ldapAttribute" : "cn", "isSingleValued" : true, "isRequired" : true, "writability" : "readOnly" } },
    "members"    : { "reference" : {
      "ldapAttribute" : "uniqueMember",
      "baseDN"        : "dc=example,dc=com",
      "primaryKey"    : "uid",
      "mapper"        : { "object" : {
        "_id"         : { "simple"   : { "ldapAttribute" : "uid", "isSingleValued" : true, "isRequired" : true } },
        "displayName" : { "simple"   : { "ldapAttribute" : "cn", "isSingleValued" : true, "writability" : "readOnlyDiscardWrites" } }
      } }
    } },
        "meta"        : { "object" : {
          "created"      : { "simple" : { "ldapAttribute" : "createTimestamp", "isSingleValued" : true, "writability" : "readOnly" } },
          "lastModified" : { "simple" : { "ldapAttribute" : "modifyTimestamp", "isSingleValued" : true, "writability" : "readOnly" } }
        } }
    }
}
EOS

default[:rest2ldap][:mappings] = mappings
