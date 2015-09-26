class jobseconomy(String $listen_addresses            = 'localhost',
                  String $gunicorn_user               = 'webserv',
                  String $webserv_db_user             = 'webserv',
                  String $webserv_db_password         = undef,
                  String $webserv_db_privilege        = 'SELECT',
                  Optional[String] $admin_db_user     = undef,
                  Optional[String] $admin_db_password = undef,
                  String $database                    = 'jobseconomy',
                  String $source                      = undef) {
  class { 'jobseconomy::database':
    webserv_user     => $webserv_db_user,
    webserv_password => $webserv_db_password,
    admin_user       => $admin_db_user,
    admin_password   => $admin_db_password,
    database         => $database
  }

  class { 'jobseconomy::webserv':
    listen_addresses => $listen_addresses,
    user             => $gunicorn_user,
    db_user          => $webserv_db_user,
    db_password      => $webserv_db_password,
    source           => $source
  }
}
