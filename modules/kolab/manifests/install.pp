class kolab::install {

  # remove coliding packages
  package { [ 'exim4',
              'exim4-base',
              'exim4-config',
              'exim4-daemon-light' ]:
    ensure => absent,
    before => Package['kolab']
  }

  # Workaround until GPG key are fixed
  #file { '/etc/apt/apt.conf.d/99auth':
  #  owner   => root,
  #  group   => root,
  #  content => "APT::Get::AllowUnauthenticated yes;",
  #  mode    => 644,
  #  before  => Package['kolab']
  #}

  if $kolab::version == 'development' {
    apt::source {
      'kolab-debian-development':
        ensure      => present,
        location    => "http://obs.kolabsys.com/repositories/Kolab:/Development/Debian_7.0/",
        release     => '',
        repos       => './',
        pin         => '501',
        include_src => false,
        key         => '14C8875B',
        key_source  => 'http://obs.kolabsys.com/repositories/Kolab:/Development/Debian_7.0/Release.key';

      'opensuse-obs':
        ensure      => present,
        location    => 'http://download.opensuse.org/repositories/openSUSE:Tools/Debian_7.0/',
        release     => '',
        repos       => '/',
        include_src => false,
        key         => 'EEFEFDE9',
        key_source  => 'http://download.opensuse.org/repositories/openSUSE:Tools/Debian_7.0/Release.key';
    } ->
    package { [ 'kolab', 'osc', 'build' ]:
      ensure  => present,
    }
  } else {
    apt::source {
      "kolab-debian-${kolab::version}":
        ensure      => present,
        location    => "http://obs.kolabsys.com/repositories/Kolab:/${kolab::version}/Debian_7.0/",
        release     => '',
        repos       => './',
        pin         => '501',
        include_src => false,
        key         => 'B4F6D430',
        key_source  => "http://obs.kolabsys.com/repositories/Kolab:/${kolab::version}/Debian_7.0/Release.key";

      "kolab-debian-${kolab::version}-updates":
        ensure      => present,
        location    => "http://obs.kolabsys.com/repositories/Kolab:/${kolab::version}:/Updates/Debian_7.0/",
        release     => '',
        repos       => './',
        pin         => '501',
        include_src => false,
        key         => 'B4F6D430',
        key_source  => "http://obs.kolabsys.com/repositories/Kolab:/${kolab::version}:/Updates/Debian_7.0/Release.key";
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
