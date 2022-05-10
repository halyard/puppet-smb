# @summary Create an SMB mountpoint
#
# @param share sets the upstream path for the share
# @param options sets the connection options for the share
# @param path (namevar) sets the local path for the mount
define smb::mount (
  String $share,
  String $options = 'username=NULL,password=NULL',
  String $path = $title,
) {
  file { $path:
    ensure => directory,
  }

  mount { $path:
    ensure  => mounted,
    device  => $share,
    atboot  => true,
    fstype  => 'cifs',
    options => $options,
    dump    => '0',
    pass    => '2',
    require => Package['cifs-utils'],
  }
}
