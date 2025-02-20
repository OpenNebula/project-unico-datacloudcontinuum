# Description

This repository contains a tool to automatically deploy OpenNebula control planes on a bare metal host, adding the needed integrations required in the DATACLOUDCONTINUUM project to optimize the use of resources by using AI techniques.

Currently this repository deploys an OpenNebula installation with

- [Prometheus](https://prometheus.io/)
- [Scaphandre](https://hubblo-org.github.io/scaphandre-documentation/index.html) (energy consumption metrics)
- [OneKE](https://github.com/OpenNebula/one-apps/wiki/oneke_intro)

TODO: Add AIOps

## How to use

The installation process consists of two steps. The first step installs opennebula using [one-deploy](https://github.com/OpenNebula/one-deploy) the second step sets up [OneKE](https://github.com/OpenNebula/one-apps/wiki/oneke_intro) using the [terraform-opennebula](https://registry.terraform.io/providers/OpenNebula/opennebula/latest/docs) provider.

### Requirements

**Hardware**

- 1 bare metal server with at least:
  - 1 CPU 8 cores
  - 64 GB RAM
  - 500GB Hard disk
  - Internet connectivity

**Software**

- [ansible](https://github.com/OpenNebula/one-deploy/wiki/sys_reqs#requirements)
- terraform
- GNU make

### Installation

Clone this repository in the bare metal resource.

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

### Post Installation

Once deployed, hypervisor nodes and VM networking can be added with [oneprovision](https://docs.opennebula.io/6.10/provision_clusters/edge_clusters/overview.html).
