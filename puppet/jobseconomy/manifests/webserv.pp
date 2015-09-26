class jobseconomy::webserv(String $source                  = undef,
                            String $user                    = undef,
                            String $db_user                 = undef,
                            String $db_password             = undef,
                            String $listen_addresses        = undef) {

  $home = "/home/${user}"
  $venv = "${home}/venv"
  $gunicorn_bind = "unix:${home}/jobseconomy.socket"

  user { $user:
    ensure     => present,
    managehome => true,
    home       => $home,
  }

  class { 'python':
    version    => '3',
    virtualenv => true,
    dev        => true,
    gunicorn   => true,
  }

  python::virtualenv { $venv:
    version      => '3',
    virtualenv   => 'virtualenv',
    requirements => "${source}/setup/requirements.txt",
    owner        => $user,
    group        => $user,
  }

  python::requirements { "${source}/setup/server-requirements.txt":
    virtualenv => $venv,
    owner      => $user,
    group      => $user
  }

  python::gunicorn { 'api':
    virtualenv => $venv,
    dir        => $source,
    bind       => $gunicorn_bind,
  }

  class { 'nginx': }
  nginx::resource::vhost { 'jobseconomy':
    proxy => "http://${gunicorn_bind}"
  }

  class { 'postgresql::client': }
  class { 'postgresql::lib::devel': }
}
