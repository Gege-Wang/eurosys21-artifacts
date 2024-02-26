WORKDIR=$(realpath $(dirname $0))

HELLO_SIZE=`du --block-size=1 $WORKDIR/mirage-helloworld/helloworld.hvt | tail -n 1 | awk '{ print $1 }'`
echo ${HELLO_SIZE} > $WORKDIR/../results/mirage-hello.csv
