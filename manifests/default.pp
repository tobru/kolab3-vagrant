include apt

class { 'kolab':
  version => 'development';
}

# some tools for convenience
package { [ 'vim' ]:
  ensure => present;
}
