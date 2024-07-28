# Define the directories for installation
PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin/
SHAREDIR = $(PREFIX)/share/engine-stressor
SHAREDIR_DOC = $(PREFIX)/share/doc/engine-stressor
CONFIGDIR = $(HOME)/.config/engine-stressor

# Define the list of scripts and files
SCRIPTS = cgroup \
	memory \
	engine \
	network \
	engine-operations \
	disk-exhaustion/disk-exhaustion \
	memory-exhaustion/memory-exhaustion \
	processes \
	volume \
	stress \
	systemd \
	system \
	date \
	rpm \
	common \
	monitor \
	selinux

BIN_FILE = engine-stressor

DOCS = README.md LICENSE SECURITY.md NOTICE

CONFIG_FILE = constants

DNF_OR_YUM:=$(shell which dnf || which yum)

# Default target
all:
	@echo "Available targets: install, uninstall"

# Install target
install: installdeps
	@install -d $(DESTDIR)$(SHAREDIR)
	@install -d $(DESTDIR)$(SHAREDIR_DOC)
	@install -d $(DESTDIR)$(BINDIR)
	@install -d $(DESTDIR)$(CONFIGDIR)
	@for script in $(SCRIPTS); do \
                install -m 755 $$script $(DESTDIR)$(SHAREDIR); \
        done
	@for doc in $(DOCS); do \
                install -m 644 $$doc $(DESTDIR)$(SHAREDIR_DOC); \
        done
	@install -m 755 $(BIN_FILE) $(DESTDIR)$(BINDIR)
	@install -m 644 $(CONFIG_FILE) $(DESTDIR)$(CONFIGDIR)/$(CONFIG_FILE)
	@if ! grep -q '^SHARE_DIR=$(SHAREDIR)' $(DESTDIR)$(CONFIGDIR)/$(CONFIG_FILE); then \
                echo 'SHARE_DIR=$(SHAREDIR)' >> $(DESTDIR)$(CONFIGDIR)/$(CONFIG_FILE); \
        fi
	@echo "Installation complete via PREFIX: $(PREFIX)"
	@echo "  - bin: $(DESTDIR)$(BINDIR)$(BIN_FILE)"
	@echo "  - docs: $(DESTDIR)$(SHAREDIR_DOC)"
	@echo "  - libs: $(DESTDIR)$(SHAREDIR)"

installdeps:
	@if test -x "$(DNF_OR_YUM)"; then rpm -q aardvark-dns > /dev/null 2>&1 || $(DNF_OR_YUM) -y install aardvark-dns; fi

# Uninstall target
uninstall:
	@for script in $(SCRIPTS); do \
                rm -f $(DESTDIR)$(SHAREDIR)/$$script; \
        done
	rm -rf $(DESTDIR)$(SHAREDIR)
	rm -rf $(DESTDIR)$(SHAREDIR_DOC)
	rm -rf $(DESTDIR)$(CONFIGDIR)
	rm -f $(DESTDIR)$(BINDIR)/$(BIN_FILE)
	@echo "Uninstallation complete."

.PHONY: all install uninstall

