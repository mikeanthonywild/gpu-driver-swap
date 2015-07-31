SYSTEMD_SCRIPT_DIR  = /usr/lib/systemd/scripts
SYSTEMD_SERVICE_DIR = /etc/systemd/system

all:
	echo "Nothing to build"

install:
	install -D gpuswap.sh $(SYSTEMD_SCRIPT_DIR)/gpuswap.sh
	install -D gpu-driver-swap.service $(SYSTEMD_SERVICE_DIR)/gpu-driver-swap.service

uninstall:
	-rm $(SYSTEMD_SCRIPT_DIR)/gpuswap.sh
	-rm $(SYSTEMD_SERVICE_DIR)/gpu-driver-swap.service

.PHONY: install uninstall
