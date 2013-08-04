class graphite::install {

  package {[
    'python-ldap',
    'python-cairo',
    'python-django',
    'python-twisted',
    'python-django-tagging',
    'python-simplejson',
    'libapache2-mod-python',
    'python-memcache',
    'python-pysqlite2',
    'python-support',
    'python-pip',
  ]:
    ensure => latest;
  }

  exec { 'install-carbon':
    command => '/usr/bin/pip install carbon; echo $?',
    creates => '/opt/graphite/lib/carbon',
    require => Package['python-pip'],
  }

  exec { 'install-graphite-web':
    command => '/usr/bin/pip install graphite-web',
    creates => '/opt/graphite/webapp/graphite',
    require => Package['python-pip'],
  }

  package { 'whisper':
    ensure   => installed,
    provider => pip,
  }

  file { '/var/log/carbon':
    ensure => directory,
    owner  => www-data,
    group  => www-data,
  }

}
