#
# Files and directories
#
WORKDIR ?= $(CURDIR)
RESULTS ?= $(WORKDIR)/results
PLOT ?= $(WORKDIR)/$(notdir $(WORKDIR)).svg

#
# Tools
#
SNAKE ?= python3
DOCKER ?= docker

#
# Targets
#
.PHONY: all
all: prepare run plot

.PHONY: prepare
prepare:
	$(DOCKER) pull hlefeuvre/instrumented-vmms:latest
	$(WORKDIR)/genimages.sh

.PHONY: run
run:
	$(WORKDIR)/benchmark.sh

.PHONY: plot
plot:
	PYTHONPATH=$(WORKDIR)/../common $(SNAKE) $(WORKDIR)/plot.py --data $(RESULTS) --output $(PLOT)

.PHONY: clean
clean:
	@-
