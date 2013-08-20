class chartdirector(
  $php_version = $chartdirector::params::php_version,
  $php_extension_dir = $chartdirector::params::php_extension_dir,
) inherits chartdirector::params {
  class { 'chartdirector::install': 
    php_version       => $php_version,
    php_extension_dir => $php_extension_dir,
  }
}
