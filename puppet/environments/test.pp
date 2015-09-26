class  { 'jobseconomy':
  gunicorn_user        => 'jobseconomy',
  webserv_db_password  => 'hi',
  webserv_db_privilege => 'ALL',
  admin_db_user        => 'admin',
  admin_db_password    => 'password',
  source               => '/home/jobseconomy/backend'
}
