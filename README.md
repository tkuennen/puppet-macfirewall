# puppet-macfirewall

#### Table of Contents

1. [Description](#description)
1. [Setup requirements](#setup-requirements)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)

## Description

Manage socketfilterfw with Puppet. The code relies on exec statements, which isn't ideal, but
cleans up a lot of the code that I had originally.

Posting here for suggestions, and in case others might benefit from something similar.

## Setup

### Setup Requirements

I use r10k for managing my Puppet modules.

Add this to your Puppetfile:

mod 'puppet-macfirewall',
  :git    => 'https://github.com/avantgardefuselage/puppet-macfirewall.git',
  :commit => 'COMMIT_NUMBER'

## Usage

Example usage could be:

```
 class profile::firewall {

  macfirewall { 'Enable Firewall':
    action  => 'globalstate',
    value   => 'on',
   }

  macfirewall { 'Enable Stealthmode':
    action  => 'stealth',
    value   => 'on',
   }
 }
```

## Limitations

This was written and tested on:
- Puppet 4
- macOS 10.12.x
