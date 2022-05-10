# @summary Create an SMB mountpoint
#
# @param path (namevar) sets the local path for the mount
# @param share sets the upstream path for the share
define smb::mount (
  String $path,
  String $share,
) {
  file { $path:
    ensure => directory,
  }

  $credentials = configvault_read("smb/${path}", false, 'username=NULL,password=NULL')

  mount { $path:
    ensure  => mounted,
    device  => $share,
    atboot  => true,
    fstype  => 'cifs',
    options => $credentials,
    dump    => '0',
    pass    => '2',
    require => Package['cifs-utils'],
  }
}
