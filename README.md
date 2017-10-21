# Quagga based router labs
This project creates a virtual network of `quagga` routers. The `quagga` router instances are launched in `docker` containers using `docker-compose`. The lab environment runs in a `virtual box` VM which provisions docker containers using `ansible`.


## Getting started

```
$ vagrant up  # start the vm
$ vagrant ssh # ssh into the vm
vagrant@vagrant-ubuntu-trusty-64:/vagrant$ ansible-playbook site.yml -i inventories/ebgp-ibgp/ # topologies in /ansible/inventories
vagrant@vagrant-ubuntu-trusty-64:/vagrant$ docker ps # view routers provisioned in the topology
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
30d0620438ca        quagga              "/bin/bash -er /us..."   12 minutes ago      Up 12 minutes                           vagrant_r20_1
3f96123683ad        quagga              "/bin/bash -er /us..."   12 minutes ago      Up 12 minutes                           vagrant_r4_1
11f25a3a1d8c        quagga              "/bin/bash -er /us..."   12 minutes ago      Up 12 minutes                           vagrant_r6_1
916cf85ab079        quagga              "/bin/bash -er /us..."   12 minutes ago      Up 12 minutes                           vagrant_r11_1
a83160e1b75a        quagga              "/bin/bash -er /us..."   12 minutes ago      Up 12 minutes                           vagrant_r2_1
03032901a844        quagga              "/bin/bash -er /us..."   12 minutes ago      Up 12 minutes                           vagrant_r10_1
5909f30e054b        quagga              "/bin/bash -er /us..."   12 minutes ago      Up 12 minutes                           vagrant_r5_1
8cf1da96f2d1        quagga              "/bin/bash -er /us..."   12 minutes ago      Up 12 minutes                           vagrant_r3_1
47300f270f72        quagga              "/bin/bash -er /us..."   12 minutes ago      Up 12 minutes                           vagrant_r1_1
vagrant@vagrant-ubuntu-trusty-64:/vagrant$ r3 # get a terminal on a router, r3 is alias to docker exec -it vagrant_r3_1 /usr/bin/vtysh

Hello, this is Quagga (version 0.99.22.4).
Copyright 1996-2005 Kunihiro Ishiguro, et al.

c19b87b918df# show ip bgp summ
BGP router identifier 33.0.0.3, local AS number 100
RIB entries 17, using 1904 bytes of memory
Peers 4, using 18 KiB of memory

Neighbor        V    AS MsgRcvd MsgSent   TblVer  InQ OutQ Up/Down  State/PfxRcd
100.0.0.2       4   100     402     402        0    0    0 06:35:25        7
100.0.0.10      4    10     401     399        0    0    0 06:35:27        6
100.0.0.11      4    10     400     399        0    0    0 06:35:27        6
200.0.0.20      4    20     399     400        0    0    0 06:35:27        6

Total number of neighbors 4
c19b87b918dfty-64:/vagrant$ r3-sh # shell to the docker container where the quagga is running
#

```

## Prerequisites
We deploy everything inside a virtual box so your system will be left clean. Only software needed to manage the VM is needed:
* Virtual Box
* Vagrant

## Lab Topologies and Configurations

Once you've ssh'd into your Virtual Box lab the configurations are available in the `inventories`. From the VM select tell `ansible` which inventory to use based on your lab needs:

```ansible-playbook site.yml -i inventories/<lab configuration>```

Topologies are defined via the `inventories` directory.  In `group_vars/all.yml` networks to be used to create docker networks are defined.  In `host_vars/all.yml` vars for each router are defined.  All routers are listed in `hosts`

## Shells on Quagga Routers
We've created aliases in VirtualBox vm in `~/.bashrc` for easy access into the Quagga Routers and docker containers running the routers.

```
vagrant@vagrant-ubuntu-trusty-64:/vagrant$ r1-sh # shell on the docker container running the r1 quagga router
# cd /etc/quagga # configuration for the router
# ls
daemons  debian.conf  ospfd.conf  vtysh.conf  zebra.conf
# exit
vagrant@vagrant-ubuntu-trusty-64:/vagrant$ r1 # a shell directly on the quagga router's vtysh

```

## Quagga Configuration Templates

Python Jinja2 based templates are located in `roles/quagga-conf/templates`. These are used to generate router configs for quagga (e.g. ospfd.conf, bgpd.conf, etc.)

## Cleanup

New topologies can be launched as above repeatedly as the ansible playbook removes previous containters.  However, to completely clean up the VM (e.g. remove all docker images) run:

```
vagrant@vagrant-ubuntu-trusty-64:/vagrant$ ansible-playbook playbooks/cleanup.yml
```
