#!/usr/bin/env bash

[ -d /root/ocp ] && rm -rf /root/ocp
export LIBVIRT_DEFAULT_URI=qemu+ssh://root@{{ config_host }}/system
cluster={{ cluster }}
bootstrap=$(virsh list --all --name | grep "$cluster.*bootstrap")
if [ "$bootstrap" != "" ] ; then
for vm in $bootstrap ; do
virsh destroy $vm
virsh undefine $vm
virsh vol-delete $vm default
virsh vol-delete $vm.ign default
done
fi
