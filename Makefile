ROOT := ./

include $(ROOT)config/global.mk

DIRS :=

ifeq ($(HB_BUILD_PARTS),compiler)

   DIRS += \
      3rd \
      src \
      utils{src} \

else

   # When doing a plain clean, we must not clean hbmk2
   # before calling it to clean the contrib area.
   _CONTRIB_FIRST :=
   ifneq ($(filter clean,$(HB_MAKECMDGOALS)),)
      ifeq ($(filter install,$(HB_MAKECMDGOALS)),)
         _CONTRIB_FIRST := yes
      endif
   endif

   DIRS += \
      doc \
      include \
      3rd \
      src \

   ifeq ($(_CONTRIB_FIRST),yes)

      DIRS += \
         contrib{src} \
         utils{contrib} \

   else
   
      DIRS += \
         utils{src} \
         contrib{utils} \

   endif
endif

include $(ROOT)config/dir.mk


ifeq ($(HB_PLATFORM),win)

# every harbour execute needs zlib1.dll
SRCLIB := $(subst /,$(DIRSEP),$(HB_HAS_ZLIB)/../lib/zlib1.dll)
DESTLIB := $(subst /,$(DIRSEP),$(HB_HOST_BIN_DIR)/zlib1.dll)
DESTDIR := $(subst /,$(DIRSEP),$(HB_HOST_BIN_DIR))

hbmk2Zlib1dll::
	$(info win SHELL='$(SHELL)' cmd='$(CP)' '$(SRCLIB)' '$(DESTLIB)')
	$(if $(wildcard $(DESTDIR)),$(ECHO) dir $(DESTDIR)exists,$(MD) $(DESTDIR))
	$(CP) $(SRCLIB) $(DESTLIB)
else

# every harbour execute needs libz.so
SRCLIB := $(subst /,$(DIRSEP),$(HB_HAS_ZLIB)/../lib/libz.so)
DESTLIB := $(subst /,$(DIRSEP),$(HB_HOST_BIN_DIR)/libz.so)
DESTDIR := $(subst /,$(DIRSEP),$(HB_HOST_BIN_DIR))

hbmk2Zlib1dll::
	$(info SHELL='$(SHELL)' cmd='$(CP)' '$(SRCLIB)' '$(DESTLIB)')
	$(if $(wildcard $(DESTDIR)/../),$(ECHO) dir exists,$(MD) $(DESTDIR)/../)
	$(if $(wildcard $(DESTDIR)),$(ECHO) dir exists,$(MD) $(DESTDIR))
endif

first clean install:: hbmk2Zlib1dll
	$(if $(wildcard $(HB_HOST_BIN_DIR)/hbmk2$(HB_HOST_BIN_EXT)),+$(HB_HOST_BIN_DIR)/hbmk2$(HB_HOST_BIN_EXT) $(TOP)$(ROOT)config/postinst.hb $@,@$(ECHO) $(ECHOQUOTE)! Warning: hbmk2 not found, config/postinst.hb skipped.$(ECHOQUOTE))
	$(info == $(HB_HOST_BIN_DIR) END==)
