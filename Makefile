CWD ?= $(shell pwd)

.EXPORT_ALL_VARIABLES:
DIST := $(CWD)/dist
DIST_DIRS := $(DIST)

BLACKLIST_FILES := \
	https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/xato-net-10-million-passwords-10.txt \
	https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/xato-net-10-million-passwords-100.txt \
	https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/xato-net-10-million-passwords-1000.txt \
	https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/xato-net-10-million-passwords-10000.txt \
	https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/xato-net-10-million-passwords-100000.txt \
	https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/xato-net-10-million-passwords-1000000.txt

.PHONY: all
all: clean generate

.PHONY: clean
clean:
	@rm -rf $(DIST_DIRS)

.PHONY: generate
generate:
	@mkdir -p $(DIST)
	@$(foreach file, $(BLACKLIST_FILES), \
		curl -SsfL -o $(DIST)/$$(basename $(file)) $(file); \
		dd if=$(DIST)/$$(basename $(file)) of=$(DIST)/lowercase-$$(basename $(file)) conv=lcase status=none; \
	)
