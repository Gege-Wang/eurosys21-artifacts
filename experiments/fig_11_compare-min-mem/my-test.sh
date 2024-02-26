#!/bin/bash
BUILDDIR=../
LUPINEDIR=${BUILDDIR}/.lupine
FIRECRACKER_PATH=.firecracker
IMAGES=$(pwd)/images
VMMSOCKET=$(pwd)/.firecracker.socket
if [ ! -f "$FIRECRACKER_PATH" ]; then
        ln -s ${LUPINEDIR}/Lupine-Linux/firecracker $FIRECRACKER_PATH
fi
cp ${IMAGES}/hello.ext2 ${IMAGES}/hello.ext2.disp
./firectl --firecracker-binary=./firecracker \
        --kernel ${IMAGES}/nginx/generic-fc.kernel --memory $1 \
        --kernel-opts='panic=-1 noapic nomodules pci=off console=ttyS0 init=/bin/ash' \
        --ncpus=1 --root-drive=${IMAGES}/hello.ext2.disp
        --socket-path=$VMMSOCKET > .out 2> /dev/null
