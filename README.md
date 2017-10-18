# Quagga  based router labs

Used with Vagrant and Virtual Box to launch a VM with Ansible and Docker installed.  Quagga router instances are launched in Docker containers via docker-compose.

## Launch VM

`vagrant up`

## Example to launch a quagga router lab

`ansible-playbook site.yml -i inventories/ebgp-ibgp/`

## Connect to a router

Just enter the router name (r1, r2, etc.).  These are aliases to attach to the relevant Docker container and launch `vtysh`

```
vagrant@vagrant-ubuntu-trusty-64:/vagrant$ r3

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
c19b87b918df# 
```

## Connect to a Docker container shell (instead of quagga router interface / vtysh)

```
vagrant@vagrant-ubuntu-trusty-64:/vagrant$ r1-sh
# cd /etc/quagga
# ls
daemons  debian.conf  ospfd.conf  vtysh.conf  zebra.conf
# 

```

## Templates

Jinja2 based templates are located in `roles/quagga-conf/templates`.  These are used to generate router configs for quagga (e.g. ospfd.conf, bgpd.conf, etc.)

## Topologies

Topologies are defined via the `inventories` directory.  In `group_vars/all.yml` networks to be used to create docker networks are defined.  In `host_vars/all.yml` vars for each router are defined.  All routers are listed in `hosts`

## Cleanup

New topologies can be launched as above repeatedly as the ansible playbook removes previous containters.  However, to completely clean up the VM (e.g. remove all docker images) run:

```
vagrant@vagrant-ubuntu-trusty-64:/vagrant$ ansible-playbook playbooks/cleanup.yml 
```