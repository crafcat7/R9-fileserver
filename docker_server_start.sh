#!/bin/bash
set -x # echo on
#`getent hosts test-vm-server | awk '{ print $$1 }'` is resolving current ip address
/R9-fileserver/target/release/R9-fileserver --mount-point server_root_fs --network-address `getent hosts test-vm-server | awk '{ print $1 }'`:7878

