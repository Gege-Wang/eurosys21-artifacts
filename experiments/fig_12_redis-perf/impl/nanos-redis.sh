#!/bin/bash

# verbose output
set -x

source ../common/set-cpus.sh
source ../common/redis.sh
source ../common/qemu.sh

IMAGES=$(pwd)/images/
mkdir -p rawdata results


function cleanup {
        # kill all children (evil)
        kill_qemu
        pkill -P $$
}

trap "cleanup" EXIT

LOG=rawdata/nanos-redis.txt
RESULTS=results/nanos-qemu.csv
echo "operation        throughput" > $RESULTS
touch $LOG

for j in {1..5}
do

        # make sure that the server has properly started
        sleep 8
        ip=127.0.0.1
        # benchmark
        benchmark_redis_server ${ip} 6379

        parse_redis_results $LOG $RESULTS
done
