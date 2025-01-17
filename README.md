# Description

Install opennebula with
- prometheus
- scaphandre (energy consumption metrics)
- OneKE


## How to use

The installation process consists of two steps. The first step installs opennebula using [one-deploy](https://github.com/OpenNebula/one-deploy) the second step sets up [OneKE](https://github.com/OpenNebula/one-apps/wiki/oneke_intro) using the [terraform-opennebula](https://registry.terraform.io/providers/OpenNebula/opennebula/latest/docs) provider

### Requirements

- [ansible](https://github.com/OpenNebula/one-deploy/wiki/sys_reqs#requirements)
- terraform
- GNU make

### Installation

Some input is needed in order to bootstrap a minimal opennebula. At least a host where opennebula will be provisioned and the `oneadmin` user password. For this, create a `Makefile.local` file and enter the following information.

```bash
ONE_HOST = ip_address/hostname # where opennebula will be installed
ONE_PASSWORD = password
```

Then run

```bash
make dcc
```

You can customize other parameters, like the **one-deploy** inventory file. Please take a look at `Makefile.config` to check the possible customizations.





