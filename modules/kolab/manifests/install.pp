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

  if $kolab::version == 'development' {
    apt::source {
      'kolab-development':
        ensure      => present,
        location    => "http://obs.kolabsys.com/repositories/Kolab:/Development/${_ospath}",
        release     => '',
        repos       => './',
        pin         => '501',
        include_src => false,
        key         => '14C8875B',
        key_source  => "http://obs.kolabsys.com/repositories/Kolab:/Development/${_ospath}/Release.key";

      'opensuse-obs':
        ensure      => present,
        location    => "http://download.opensuse.org/repositories/openSUSE:Tools/x${_ospath}",
        release     => '',
        repos       => '/',
        include_src => false,
        key         => 'EEFEFDE9',
        key_source  => "http://download.opensuse.org/repositories/openSUSE:Tools/x${_ospath}/Release.key";
    } ->
    package { [ 'kolab', 'osc', 'build' ]:
      ensure  => present,
    }
  } else {
    apt::source {
      "kolab-${kolab::version}":
        ensure      => present,
        location    => "http://obs.kolabsys.com/repositories/Kolab:/${kolab::version}/${_ospath}",
        release     => '',
        repos       => './',
        pin         => '501',
        include_src => false,
        key         => '158A77FF',
        key_source  => "http://obs.kolabsys.com/repositories/Kolab:/${kolab::version}/${_ospath}/Release.key";

      "kolab-${kolab::version}-updates":
        ensure      => present,
        location    => "http://obs.kolabsys.com/repositories/Kolab:/${kolab::version}:/Updates/${_ospath}",
        release     => '',
        repos       => './',
        pin         => '501',
        include_src => false,
        key         => '158A77FF',
        key_source  => "http://obs.kolabsys.com/repositories/Kolab:/${kolab::version}:/Updates/${_ospath}/Release.key";
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
