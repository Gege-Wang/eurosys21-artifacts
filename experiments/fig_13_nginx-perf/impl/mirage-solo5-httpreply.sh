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

LOG=rawdata/mirage-solo5-httpreply.txt
touch $LOG

for j in {1..5}
do
	# make sure that the server has properly started
	sleep 5

	ip=10.0.0.2
	# benchmark
	benchmark_nginx_server ${ip}:8080 $LOG
	#curl http://${BASEIP}.2/index.html --noproxy ${BASEIP}.2 --output -

done

RESULTS=results/mirage-solo5.csv
echo "throughput_reqs" > $RESULTS
parse_nginx_results $LOG $RESULTS
