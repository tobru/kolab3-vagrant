class kolab::install {

  # remove coliding packages
  package { [ 'exim4',
              'exim4-base',
              'exim4-config',
              'exim4-daemon-light' ]:
    ensure => absent,
    before => Package['kolab']
  }

  if $kolab::version == 'development' {
    apt::source {
      'kolab-debian-development':
        ensure      => present,
        location    => 'http://obs.kolabsys.com:82/Kolab:/Development/Debian_7.0/',
        release     => '',
        repos       => './',
        pin         => '501',
        include_src => false,
        key         => '14C8875B',
        key_source  => 'http://obs.kolabsys.com:82/Kolab:/Development/Debian_7.0/Release.key';

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
        location    => "http://obs.kolabsys.com:82/Kolab:/${kolab::version}/Debian_7.0/",
        release     => '',
        repos       => './',
        pin         => '501',
        include_src => false,
        key         => 'B4F6D430',
        key_source  => "http://obs.kolabsys.com:82/Kolab:/${kolab::version}/Debian_7.0/Release.key";

      "kolab-debian-${kolab::version}-updates":
        ensure      => present,
        location    => "http://obs.kolabsys.com:82/Kolab:/${kolab::version}:/Updates/Debian_7.0/",
        release     => '',
        repos       => './',
        pin         => '501',
        include_src => false,
        key         => 'B4F6D430',
        key_source  => "http://obs.kolabsys.com:82/Kolab:/${kolab::version}:/Updates/Release.key";
    } ->
    package { 'kolab':
      ensure  => present,
    }
  }

}
