name 'rest2ldap'
maintainer 'Matt Mencel'
maintainer_email 'mr-mencel@wiu.edu'
license 'Apache 2.0'
description 'Installs/Configures the OpenDJ Rest2Ldap LDAP Gateway'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.4'

supports 'ubuntu'

depends 'tomcat', '~> 0.16.2'
