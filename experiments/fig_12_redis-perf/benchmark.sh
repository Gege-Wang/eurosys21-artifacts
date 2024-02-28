#!/bin/bash

# makes sure to run host setup
../common/setup-host.sh

mkdir rawdata results

# run benchmarks
#well ./impl/hermitux-uhyve-redis.sh
#./impl/rump-qemu-redis.sh
#./impl/osv-qemu-redis.sh
#./impl/lupine-fc-redis.sh
#./impl/lupine-qemu-redis.sh
#./impl/microvm-fc-redis.sh
#./impl/microvm-qemu-redis.sh

#well./impl/docker-redis.sh
#well./impl/native-redis.sh
./impl/unikraft-qemu-redis.sh
