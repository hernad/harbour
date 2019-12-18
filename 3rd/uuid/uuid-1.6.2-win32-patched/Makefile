
PERL     = C:\Strawberry\perl\bin\perl.exe
FULLPERL = C:\Strawberry\perl\bin\perl.exe
ARGS     = 

all pure_all:
	@if [ ! -d build ]; then mkdir build; fi
	@if [ ! -f build/Makefile ]; then (cd build && ../configure --disable-shared); fi
	@if [ ! -f build/libuuid.la ]; then (cd build && $(MAKE) $(MFLAGS) libuuid.la); fi
	@if [ ! -f perl/Makefile ]; then (cd perl && $(PERL) Makefile.PL $(ARGS)); fi
	@cd perl && $(MAKE) $(MFLAGS) $@

install pure_install test:
	@cd perl && $(MAKE) $(MFLAGS) $@

clean:
	@cd build && $(MAKE) $(MFLAGS) $@
	@cd perl && $(MAKE) $(MFLAGS) $@

distclean realclean:
	@cd build && $(MAKE) $(MFLAGS) $@
	@cd perl && $(MAKE) $(MFLAGS) $@
	-rm -rf build || true
	-rm -rf Makefile || true

