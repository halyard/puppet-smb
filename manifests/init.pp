# @summary Configure SMB mounts
#
# @param lvs sets LVs to manage
class smb (
  Hash[String, Hash] $mounts = {},
) {
  package { ['cifs-utils', 'smbclient']: }

  $smb::mounts.each | String $name, Hash $options | {
    smb::mount { $name:
      * => $options,
    }
  }
}
