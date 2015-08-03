class kolab::install {

  # remove coliding packages
  package { [ 'exim4',
              'exim4-base',
              'exim4-config',
              'exim4-daemon-light' ]:
    ensure => absent,
    before => Package['kolab']
  }

  $_ospath = $::operatingsystem ? {
    'Ubuntu' => "${::operatingsystem}_${::operatingsystemrelease}",
    'Debian' => "${::operatingsystem}_${::lsbmajdistrelease}.0",
    default  => fail("unsupported ${::operatingsystem}"),
  }
  $_ospath_suse = $::operatingsystem ? {
    'Ubuntu' => "x${::operatingsystem}_${::operatingsystemrelease}",
    'Debian' => "${::operatingsystem}_${::lsbmajdistrelease}.0",
    default  => fail("unsupported ${::operatingsystem}"),
  }

  if $kolab::version == 'development' {
    apt::source {
      'kolab-development':
        ensure      => present,
        location    => "http://obs.kolabsys.com/repositories/Kolab:/Development/${_ospath}",
        release     => ' ',
        repos       => './',
        pin         => '501',
        key         => {
          'id' => '79D86A05FDE6C9FB4E43A6C5830C2BCF446D5A45',
          'source' => "http://obs.kolabsys.com/repositories/Kolab:/Development/${_ospath}/Release.key",
        },
        include  => {
          'src' => true,
          'deb' => true,
        };
      'opensuse-obs':
        ensure      => present,
        location    => "http://download.opensuse.org/repositories/openSUSE:/Tools/${_ospath_suse}",
        release     => ' ',
        repos       => '/',
        key         => {
          'id' => '0A031153E2F5E9DB71510D8C85753AA5EEFEFDE9',
          'source' => "http://download.opensuse.org/repositories/openSUSE:/Tools/${_ospath_suse}/Release.key",
        },
        include  => {
          'src' => true,
          'deb' => true,
        };
    } ->
    package { [ 'kolab', 'osc', 'build' ]:
      ensure  => present,
    }
  } else {
    apt::source {
      "kolab-${kolab::version}":
        ensure      => present,
        location    => "http://obs.kolabsys.com/repositories/Kolab:/${kolab::version}/${_ospath}",
        release     => ' ',
        repos       => './',
        pin         => '501',
        key         => {
          'id' => '79D86A05FDE6C9FB4E43A6C5830C2BCF446D5A45',
          'source' => "http://obs.kolabsys.com/repositories/Kolab:/Development/${_ospath}/Release.key",
        },
        include  => {
          'src' => true,
          'deb' => true,
        };
      "kolab-${kolab::version}-updates":
        ensure      => present,
        location    => "http://obs.kolabsys.com/repositories/Kolab:/${kolab::version}:/Updates/${_ospath}",
        release     => ' ',
        repos       => './',
        pin         => '501',
        key         => {
          'id' => '79D86A05FDE6C9FB4E43A6C5830C2BCF446D5A45',
          'source' => "http://obs.kolabsys.com/repositories/Kolab:/Development/${_ospath}/Release.key",
        },
        include  => {
          'src' => true,
          'deb' => true,
        };
    } ->
    package { 'kolab':
      ensure  => present,
    }
  }

  if $kolab::version == '3.3' {
    file { '/usr/share/pyshared/pykolab/setup/setup_roundcube.py':
      source  => 'puppet:///modules/kolab/fix-3.3-setup_roundcube.py',
      require => Package['kolab'],
    }
  }

}
