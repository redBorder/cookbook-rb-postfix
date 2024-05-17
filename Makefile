.DEFAULT_GOAL:=help
.SILENT:

all: rpm

rpm:
	$(MAKE) -C packaging/rpm rpm

clean:
	$(MAKE) -C packaging/rpm clean

distclean:
	$(MAKE) -C packaging/rpm distclean

help:
	$(MAKE) -C packaging/rpm
