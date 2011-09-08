class network-bothip::install {

  package { "vlan":
    ensure  => latest,
  }

  file { "/etc/network/interfaces":
    content => template("network-bothip/interfaces.erb"),
    mode    => 0644,
    backup  => true,
    require => Package["vlan"],
    notify  => Exec["restart_network"]
  }

  exec { "restart_network":
    command     => "/etc/init.d/networking restart && sleep 60",
    path        => [ "/bin", "/usr/bin" ],
    notify  => Service["nova-network"],
    refreshonly => true
  }
}

