# == Class: kibana::params
#
# This class sets default parameters
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
class kibana::params {

  $version                = '4.0.1'
  $base_url               = 'https://download.elasticsearch.org/kibana/kibana'
  $install_path           = '/opt'
  $tmp_dir                = '/tmp'
  $port                   = 5601
  $bind                   = '0.0.0.0'
  $es_url                 = 'http://localhost:9200'
  $es_preserve_host       = true
  $kibana_index           = '.kibana'
  $default_app_id         = 'discover'
  $request_timeout        = 300000
  $shard_timeout          = 0
  $group                  = 'kibana'
  $verify_ssl             = true
  $user                   = 'kibana'
  $elasticsearch_username = 'user'
  $elasticsearch_password = 'pass'

  case $::operatingsystem {
    'RedHat', 'CentOS', 'Fedora', 'Scientific', 'Amazon', 'OracleLinux', 'SLC': {

      if versioncmp($::operatingsystemmajrelease, '7') >= 0 {
        $service_provider     = 'systemd'
      } else {
        $service_provider     = 'init'
        $init_script_osdependend = 'kibana.legacy.service.redhat.erb'
      }

    }

    'Debian': {

      if versioncmp($::operatingsystemmajrelease, '8') >= 0 {
        $service_provider = 'systemd'
      } else {
        $service_provider = 'init'
        $init_script_osdependend = 'kibana.legacy.service.debian.erb'
      }
    }

    'Ubuntu': {

      if versioncmp($::operatingsystemmajrelease, '15') >= 0 {
        $service_provider = 'systemd'
      } else {
        $service_provider = 'init'
        $init_script_osdependend = 'kibana.legacy.service.debian.erb'
      }
    }

    'OpenSuSE': {
      $service_provider  = 'systemd'
    }

    default: {
      $service_provider     = 'init'
      $init_script_osdependend = 'kibana.legacy.service.redhat.erb'
    }
  }
}
