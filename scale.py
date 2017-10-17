from netaddr import *

template = """interfaces:
- name: lo
  ipv4:
    primary: {0}/32

- name: eth0
  ipv4:
    primary: {1}/16
  network: internal
  ospf_hello_interval: 60
  ospf_dead_interval: 600

ospf:
  networks:
  - prefix: 0.0.0.0/0
    area: 0"""


scale = 1000

hosts_counter = 1
hosts_file = open('inventories/scale/hosts', 'w')
while hosts_counter <= scale:
    hosts_file.write('r{0}\r\n'.format(hosts_counter))
    hosts_counter += 1
hosts_file.close()

vars_counter = 1
base_sharedip = IPAddress('10.0.0.0')
base_localip = IPAddress('50.0.0.0')
while vars_counter <= scale:
    vars_file = open('inventories/scale/host_vars/r{0}'.format(vars_counter), 'w')
    if vars_counter == 1:
      vars_file.write(template.format('111.0.0.111','10.0.111.1'))
    else:
      sharedip = base_sharedip + vars_counter
      localip = base_localip + vars_counter
      vars_file.write(template.format(str(localip), str(sharedip)))
    vars_file.close()
    vars_counter += 1




