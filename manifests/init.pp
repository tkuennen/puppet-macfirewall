#
# Example usage:
#
#  class profile::firewall {
#
#     macfirewall { 'Enable Firewall':
#       action  => 'globalstate',
#       value   => 'on',
#     }
#
#     macfirewall { 'Enable Stealthmode':
#        action  => 'stealth',
#        value   => 'on',
#     }
#   }
#

define macfirewall ($action = 'string', $value = 'string', $output = false) {

  # Works only on Darwin
  if $facts['os']['name'] != 'Darwin' {
    fail('The macfirewall resource type is only supported on macOS')
  }

  # Commands for interpolation / shorthand
  $cmd = '/usr/libexec/ApplicationFirewall/socketfilterfw'
  $grep = '/usr/bin/grep'

  case $::operatingsystem {
    'Darwin': {

      # Options
      case $action {

        'add': {
          exec { "${cmd} --add ${value}":
            command   => "${cmd} --add ${value}",
            logoutput => $output,
            unless    => "${cmd} --listapps | ${grep} ${value}",
          } # end exec
        } # end add

        'block': {
          exec { "${cmd} --blockapp ${value}":
            command   => "${cmd} --blockapp ${value}",
            logoutput => $output,
            onlyif    => "${cmd} --listapps | ${grep} ${value}",
          } # end exec
        } # end block

        'remove': {
          exec { "${cmd} --remove ${value}":
            command   => "${cmd} --remove ${value}",
            logoutput => $output,
            onlyif    => "${cmd} --listapps | ${grep} ${value}",
          } # end exec
        } # End remove

        'stealth': {
          exec { "${cmd} --setstealthmode ${value}":
            command   => "${cmd} --setstealthmode ${value}",
            logoutput => $output,
            unless    => "${cmd} --getstealthmode | ${grep} ${value}",
          } # end exec
        } # end stealth

        'globalstate': {
          exec { "${cmd} --setglobalstate ${value}":
            command   => "${cmd} --setglobalstate ${value}",
            logoutput => $output,
            unless    => "${cmd} --getglobalstate | ${grep} ${value}",
          } # end exec
        } # end globalstate

        'logging': {
          exec { "${cmd} --setloggingmode ${value}":
            command   => "${cmd} --setloggingmode ${value}",
            logoutput => $output,
            unless    => "${cmd} --getloggingmode | ${grep} ${value}",
          } # end exec
        } # end logging

        'signed': {
          exec { "${cmd} --setallowsigned ${value}":
            command   => "${cmd} --setallowsigned ${value}",
            logoutput => $output,
            unless    => "${cmd} --getallowsigned | ${grep} ${value}",
          } # end exec
        } # end signed

        'signedapps': {
          exec { "${cmd} --setallowsignedapp ${value}":
            command   => "${cmd} --setallowsignedapp ${value}",
            logoutput => $output,
            unless    => "${cmd} --getallowsigned | ${grep} ${value}",
          } # end exec
        } # end signedapps

        'blockall': {
          exec { "${cmd} --setblockall ${value}":
            command   => "${cmd} --setblockall ${value}",
            logoutput => $output,
            unless    => "${cmd} --getblockall | ${grep} ${value}",
          } # end exec
        } # end blockall

        default: {
          fail('The action used is not defined. Please use a defined action.')
        }
      } # end case $action
    } # end case $::operatingsystem
    default: {
      fail('The macfirewall can only be used on macOS.')
    }
  } # end case Darwin
} # end define
