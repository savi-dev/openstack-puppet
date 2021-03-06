class ssh::config {
  file { "/etc/ssh/sshd_config":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => 0600,
    source  => "puppet:///modules/ssh/sshd_config",
    require => Class["ssh::install"],
    notify  => Class["ssh::service"]
  }

  file { "/root/.ssh":
    ensure => directory,
    owner  => "root",
    group  => "root",
    mode   => 0700
  }

  # FIXME: (rp) should also set up root pw
  file { "/root/.ssh/authorized_keys":
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => 0600,
    content => $root_authorized_keys,
    require => File["/root/.ssh"]
  }
}
    
