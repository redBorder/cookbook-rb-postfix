.DEFAULT_GOAL:=help

PACKAGE_NAME?=	cookbook-rb-postfix

VERSION?=	$(shell git describe --abbrev=6 --tags HEAD --always | sed 's/-/_/g')

BUILD_NUMBER?= 1

MOCK_CONFIG?=default

RESULT_DIR?=pkgs

##@ Build rpm packages
all: rpm

SOURCES:
	mkdir -p SOURCES

archive: SOURCES
	cd ../../ && \
	git archive --prefix=$(PACKAGE_NAME)-$(VERSION)/ \
		-o packaging/rpm/SOURCES/$(PACKAGE_NAME)-$(VERSION).tar.gz HEAD

build_prepare: archive
	mkdir -p $(RESULT_DIR)
	rm -f $(RESULT_DIR)/$(PACKAGE_NAME)*.rpm

srpm: build_prepare
	/usr/bin/mock \
		-r $(MOCK_CONFIG) \
		--define "__version $(VERSION)" \
		--define "__release $(BUILD_NUMBER)" \
		--resultdir=$(RESULT_DIR) \
		--buildsrpm \
		--spec=${PACKAGE_NAME}.spec \
		--sources=SOURCES
	@echo "======= Source RPM now available in $(RESULT_DIR) ======="

rpm: srpm                  ## build the rpm packages
	/usr/bin/mock \
		-r $(MOCK_CONFIG) \
		--define "__version $(VERSION)"\
		--define "__release $(BUILD_NUMBER)"\
		--resultdir=$(RESULT_DIR) \
		--rebuild $(RESULT_DIR)/$(PACKAGE_NAME)*.src.rpm
	@echo "======= Binary RPMs now available in $(RESULT_DIR) ======="

##@ Clean
clean:                      ## remove files in SOURCES and pkgs
	rm -rf SOURCES pkgs

distclean: clean           ## remove logs and files in SOURCES and pkgs
	rm -f build.log root.log state.log available_pkgs installed_pkgs \
		*.rpm *.tar.gz

##@ Help
help:                   ## Show this help.
		@echo "rb-postfix Makefile"
		@echo "==================="
		@echo " - PACKAGE_NAME : $(PACKAGE_NAME)"
		@echo " - VERSION : git commit or git tag"
		@echo " - BUILD_NUMBER : $(BUILD_NUMBER)"
		@echo " - MOCK_CONFIG : $(MOCK_CONFIG)"
		@echo " - RESULT_DIR : $(RESULT_DIR)"
		@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)