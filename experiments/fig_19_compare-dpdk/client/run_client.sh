../aux/..dpdk/app/dpdk-testpmd -d ./lib/librte_pipeline.so.3 -d ./drivers/librte_pmd_octeontx.so.1 -d ./drivers/librte_mempool_octeontx.so.1  -d ./lib/librte_timer.so.1 -d ./lib/librte_ethdev.so.12   -m 1024 -n 4 --proc-type=primary --in-memory  -- -i


# in testpmd
port stop all
set fwd rxonly
start
