CPU1=4
CPU4=7
CONTAINER=osv-tmp
docker pull hlefeuvre/osv
docker run --rm --privileged --name=$CONTAINER \
			--cpuset-cpus="${CPU1}-${CPU4}" \
			-v $(pwd)/data:/data-imported \
			-dt hlefeuvre/osv
docker exec -it $CONTAINER cp /data-imported/redis.conf \
		   /root/osv/apps/redis-memonly/redis.conf
docker exec -it $CONTAINER sed -i -e "s/always-show-logo/#always-show-logo/" \
		   /root/osv/apps/redis-memonly/redis.conf
docker exec -it $CONTAINER sed -i -e "s/replica-serve-stale/#replica-serve-stale/" \
		   /root/osv/apps/redis-memonly/redis.conf
docker exec -it $CONTAINER sed -i -e "s/supervised/#supervised/" \
		   /root/osv/apps/redis-memonly/redis.conf
docker exec -it $CONTAINER sed -i -e "s/replica-lazy-flush/#replica-lazy-flush/" \
		   /root/osv/apps/redis-memonly/redis.conf
docker exec -it $CONTAINER sed -i -e "s/aof-load-truncated/#aof-load-truncated/" \
		   /root/osv/apps/redis-memonly/redis.conf
docker exec -it $CONTAINER sed -i -e "s/aof-use-rdb-preamble/#aof-use-rdb-preamble/" \
		   /root/osv/apps/redis-memonly/redis.conf
docker exec -it $CONTAINER sed -i -e "s/dynamic-hz/#dynamic-hz/" \
		   /root/osv/apps/redis-memonly/redis.conf
docker exec -it $CONTAINER sed -i -e "s/stream-node-/#stream-node-/" \
		   /root/osv/apps/redis-memonly/redis.conf
docker exec -it $CONTAINER sed -i -e "s/list-max-ziplist-size -2/list-max-ziplist-entries 512/" \
		   /root/osv/apps/redis-memonly/redis.conf
docker exec -it $CONTAINER sed -i -e "s/list-compress-depth 0/list-max-ziplist-value 64/" \
		   /root/osv/apps/redis-memonly/redis.conf
docker exec -it $CONTAINER sed -i -e "s/hll-sparse-max-byte/#hll-sparse-max-byte/" \
		   /root/osv/apps/redis-memonly/redis.conf
docker exec -it $CONTAINER sed -i -e "s/rdb-save-incremental-fsync/#rdb-save-incremental-fsync/" \
		   /root/osv/apps/redis-memonly/redis.conf
docker exec -it $CONTAINER sed -i -e "s/latency-monitor-threshold/#latency-monitor-threshold/" \
		   /root/osv/apps/redis-memonly/redis.conf
docker exec -it $CONTAINER sed -i -e "s/replica/slave/" \
		   /root/osv/apps/redis-memonly/redis.conf
docker exec -it $CONTAINER sed -i -e "s/lazyfree-/#lazyfree-/" \
		   /root/osv/apps/redis-memonly/redis.conf
docker exec -it $CONTAINER bash -c \
	"cd /root/osv &&./scripts/build -j4 fs=zfs image=redis-memonly"
