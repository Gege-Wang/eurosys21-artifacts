#!/bin/bash

# verbose output
set -x

source ../common/set-cpus.sh
source ../common/network.sh
source ../common/nginx.sh
source ../common/qemu.sh

IMAGES=images
BASEIP=172.190.0
NETIF=tux0
LOG=rawdata/lupine-qemu-nginx.txt
mkdir -p rawdata
touch $LOG

echo "creating bridge"
#brctl addbr $NETIF || true
#ifconfig $NETIF ${BASEIP}.1
#killall -9 qemu-system-x86
#pkill -9 qemu-system-x86
create_bridge $NETIF $BASEIP
kill_qemu

dnsmasq_pid=$(run_dhcp $NETIF $BASEIP)

function cleanup {
	# kill all children (evil)
	#ifconfig $NETIF down
	#brctl delbr $NETIF
	kill_dhcp $dnsmasq_pid
	delete_bridge $NETIF
	rm ${IMAGES}/nginx.ext2.disposible
	#killall -9 qemu-system-x86
	#pkill -9 qemu-system-x86
	kill_qemu
	pkill -P $$
}

trap "cleanup" EXIT

for j in {1..5}
do
	cp ${IMAGES}/nginx.ext2 ${IMAGES}/nginx.ext2.disposible

	taskset -c ${CPU1} ./qemu-guest \
		-k ${IMAGES}/lupine-qemu.kernel \
		-d ${IMAGES}/nginx.ext2 \
		-a "root=/dev/vda rw console=ttyS0 init=/guest_start.sh /trusted/nginx" \
                -m 1024 -p ${CPU2}\
		-b ${NETIF} -x

	# make sure that the server has properly started
	sleep 3

	ip=`cat $(pwd)/dnsmasq.log | \
		grep "dnsmasq-dhcp: DHCPACK(${NETIF})" | \
		tail -n 1 | awk  '{print $3}'`
	
	# benchmark
	benchmark_nginx_server ${ip} $LOG
	#curl http://${BASEIP}.2/index.html --noproxy ${BASEIP}.2 --output -

	# stop server
	killall -9 qemu-system-x86
	pkill -9 qemu-system-x86
	rm ${IMAGES}/nginx.ext2.disposible
done

RESULTS=results/lupine-qemu.csv
echo "throughput_reqs" > $RESULTS
parse_nginx_results $LOG $RESULTS
