#!/bin/bash

# verbose output
set -x

source ../common/set-cpus.sh
source ../common/nginx.sh
source ../common/qemu.sh

IMAGES=images/
mkdir -p rawdata results


function cleanup {
	# kill all children (evil)
	kill_qemu
	pkill -P $$
}

trap "cleanup" EXIT

LOG=rawdata/nanos-nginx.txt
touch $LOG

for j in {1..5}
do
	# make sure that the server has properly started
	sleep 5

	ip=127.0.0.1
	# benchmark
	benchmark_nginx_server ${ip}:8083 $LOG
	#curl http://${BASEIP}.2/index.html --noproxy ${BASEIP}.2 --output -

done

RESULTS=results/nanos-qemu.csv
echo "throughput_reqs" > $RESULTS
parse_nginx_results $LOG $RESULTS
