SYSTEMD_SCRIPT_DIR  = /usr/lib/systemd/scripts
SYSTEMD_SERVICE_DIR = /etc/systemd/system

all:
	echo "Nothing to build"

install:
	install -D -m 00755 gpuswap.sh $(DESTDIR)$(SYSTEMD_SCRIPT_DIR)/gpuswap.sh
	install -D -m 00644 gpu-driver-swap.service $(DESTDIR)$(SYSTEMD_SERVICE_DIR)/gpu-driver-swap.service

uninstall:
	-rm $(DESTDIR)$(SYSTEMD_SCRIPT_DIR)/gpuswap.sh
	-rm $(DESTDIR)$(SYSTEMD_SERVICE_DIR)/gpu-driver-swap.service

.PHONY: install uninstall
