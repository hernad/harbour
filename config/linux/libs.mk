SYSLIBPATHS :=

ifneq ($(HB_LINKING_RTL),)
   ifneq ($(HB_HAS_PNG),)
      ifeq ($(HB_HAS_PNG_LOCAL),)
         SYSLIBS += png
      endif
   endif
   ifneq ($(HB_HAS_X11),)
      SYSLIBS += X11
      # add 64-bit lib dir needed for some distros (Red Hat)
      ifneq ($(findstring 64,$(shell uname -m)),)
         SYSLIBPATHS += /usr/X11R6/lib64
      endif
      SYSLIBPATHS += /usr/X11R6/lib
   endif
   ifneq ($(HB_HAS_GPM),)
      SYSLIBS += gpm
   endif
   ifneq ($(HB_HAS_PCRE2),)
      ifeq ($(HB_HAS_PCRE2_LOCAL),)
         SYSLIBS += pcre2-8
      endif
   else ifneq ($(HB_HAS_PCRE),)
      ifeq ($(HB_HAS_PCRE_LOCAL),)
         SYSLIBS += pcre
      endif
   endif
   ifneq ($(HB_HAS_ZLIB),)
      SYSLIBS += z
      SYSLIBPATHS += $(HB_HAS_ZLIB)../lib
   endif
   ifneq ($(HB_HAS_POSTGRESQL),)
      SYSLIBS += pq
      SYSLIBPATHS += $(HB_HAS_POSTGRESQL)../lib
   endif
   ifneq ($(HB_HAS_OPENSSL),)
      SYSLIBS += ssl
      SYSLIBPATHS += $(HB_HAS_SSL)../lib
   endif

   SYSLIBS += dl
   # Don't seem to be needed here, but added it for reference to move/copy
   # it to *nix platforms where this is required
   ifneq ($(HB_LINKING_VMMT),)
      SYSLIBS += pthread
   endif
else
   ifeq ($(BUILD_SHARED),yes)
      SYSLIBS += pthread
   endif
endif

SYSLIBS += m rt
