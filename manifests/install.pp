class chartdirector::install(
  $php_version,
  $php_extension_dir
) {

  if !defined(Package['php5-fpm']) {
    package {'php5-fpm': ensure => installed }
  }

  if($architecture == 'i386') {
    $tar_file = 'chartdir_php_linux.tar.gz'
  } else {
    $tar_file = 'chartdir_php_linux_64.tar.gz'
  }

  exec { 'download':
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    command => "wget http://download2.advsofteng.com/${tar_file}",
    cwd     => '/tmp',
  }
  exec { 'extract':
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    command => "tar -xf ${tar_file}",
    cwd     => '/tmp',
    require => Exec['download'],
  }
  file { "/usr/lib/php5/${chartdirector::php_extension_dir}":
    recurse => true,
    source  => '/tmp/ChartDirector/lib',
    require => Exec['extract']
  }
  file {'/etc/php5/fpm/conf.d/chartdir.ini':
    ensure  => 'present',
    content => template('chartdirector/chartdir.ini.erb'),
    require => Package['php5-fpm']
  }
}
