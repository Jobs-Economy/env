class jobseconomy::database(String $listen_addresses         = 'localhost',
                            String $webserv_user             = 'webserv',
                            String $webserv_password         = undef,
                            String $webserv_privilege        = 'SELECT',
                            Optional[String] $admin_user     = undef,
                            Optional[String] $admin_password = undef,
                            String $database                 = 'jobseconomy') {
  class { 'postgresql::server': }

  postgresql::server::database { $database:
  }

  postgresql::server::role { $admin_user:
    password_hash => postgresql_password($admin_user, $admin_password),
  }

  postgresql::server::database_grant { "${database}-admin":
    privilege => 'ALL',
    db        => $database,
    role      => $admin_user,
  }

  postgresql::server::role { $webserv_user:
    password_hash => postgresql_password($webserv_user, $webserv_password),
  }
  postgresql::server::database_grant { "${database}-webserv":
    privilege => $webserv_privilege,
    db        => $database,
    role      => $webserv_user
  }
}
