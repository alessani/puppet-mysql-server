class install_mysql_server (
  $root_password = 'root',
  $innodb_buffer_pool_size = '128M',
  $application_user = 'user',
  $application_password = '*2470C0C06DEE42FD1618BB99005ADCA2EC9D1E19', # password
  $backup_password = 'backup',
  $backup_dir = '/var/backups',
  $data_dir = '/var/lib/mysql',
) {

  class {'::mysql::server':
    root_password => $root_password,
    override_options => {
      'mysqld' => {
          'innodb_buffer_pool_size' => $innodb_buffer_pool_size,
          'datadir' => $data_dir
        }
    }
  }

  class {'::mysql::server::backup':
    backupuser => 'backup',
    backuppassword => $backup_password,
    backupdir => $backup_dir,
    backuprotate => '5',
    ensure => present
  }

  Class['::mysql::server'] -> Class['::mysql::server::backup']

}