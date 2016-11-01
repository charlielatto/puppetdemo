class puppetdemo {

  package { 'apache2':
    ensure => present,
  }

  file { ['/var/www','/var/www/html']:
    ensure => directory,
  }

  file { '/var/www/html/index.html':
    ensure => file,
    content => template('puppetdemo/index.html.erb'),
  }

  file { '/etc/apache2/apache2.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    source => 'puppet:///modules/puppetdemo/apache2.conf',
    require => Package['apache2'],
  }

  service { 'apache2':
    ensure => running,
    subscribe => File['/etc/apache2/apache2.conf'],
  }

}
