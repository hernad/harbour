include $(TOP)$(ROOT)config/global.mk

# Assemble template lib list to help create a few common variations

BUILD_SHARED :=
ifeq ($(flavor LIBS),recursive)
   ifeq ($(HB_BUILD_SHARED),yes)
      BUILD_SHARED := yes
   endif
endif

ifeq ($(BUILD_SHARED),yes)
   #hbdebug
   HB_LIBS_TPL := \
      hbcplr \

   ifeq ($(HB_PLATFORM),cygwin)
      HB_LIBS_TPL += hbmainstd
   else ifneq ($(filter $(HB_PLATFORM),win),)
      ifneq ($(filter $(HB_COMPILER),mingw mingw64 mingwarm),)
         HB_LIBS_TPL += hbmainstd
      else
         HB_LIBS_TPL += hbmainstd hbmainwin
      endif
   endif

   HB_LIBS_ST_RDD := $(HB_LIBS_TPL) $(HB_IMPLIB_BASE)
   HB_LIBS_MT_RDD := $(HB_LIBS_TPL) $(HB_IMPLIB_BASE)
   HB_LIBS_ST_NORDD := $(HB_LIBS_ST_RDD)
   HB_LIBS_MT_NORDD := $(HB_LIBS_ST_RDD)

   HB_LIBS_TPL :=
else
   # (have to use '=' operator here)
   #hbdebug 
   HB_LIBS_TPL = \
      hbextern \
      $(_HB_VM) \
      hbrtl \
      hblang \
      hbcpage \
      $(HB_GT_LIBS) \
      $(_HB_RDD) \
      hbrtl \
      $(_HB_VM) \
      hbmacro \
      hbcplr \
      hbpp \
      hbcommon \
   
   #ifneq ($(HB_HAS_ZLIB_LOCAL),)
   #   HB_LIBS_TPL += zlib
   #endif
   ifneq ($(HB_HAS_PCRE2_LOCAL),)
      HB_LIBS_TPL += hbpcre2
   endif

   # e.g. 3rd/x86/zlib/{include, bin}
   ifneq ($(HB_HAS_ZLIB),)
      ifeq ($(HB_PLATFORM),win)
         HB_LIBS_TPL += zdll
         SRCLIB := $(subst /,$(DIRSEP),$(HB_HAS_ZLIB)/../lib/zdll.lib)
         DESTLIB := $(subst /,$(DIRSEP),$(TOP)$(ROOT)lib/$(PLAT_COMP)/zdll.lib)
         ifeq ($(wildcard $(DESTLIB)),)
            RET := $(shell $(CP) $(SRCLIB) $(DESTLIB))
            $(info SHELL='$(SHELL)' cmd='$(CP)' '$(SRCLIB)' '$(DESTLIB)' => $(RET) )
         endif
         # copy the static zlib.lib also
         SRCLIB := $(subst /,$(DIRSEP),$(HB_HAS_ZLIB)/../lib/zlib.lib)
         DESTLIB := $(subst /,$(DIRSEP),$(TOP)$(ROOT)lib/$(PLAT_COMP)/zlib.lib)
         ifeq ($(wildcard $(DESTLIB)),)
            RET := $(shell $(CP) $(SRCLIB) $(DESTLIB))
            $(info SHELL='$(SHELL)' cmd='$(CP)' '$(SRCLIB)' '$(DESTLIB)' => $(RET) )
         endif
      else
         HB_LIBS_TPL += z
      endif
   endif

   ifneq ($(HB_HAS_XLSWRITER_LOCAL),)
      HB_LIBS_TPL += xlsxwriter
   endif
   ifneq ($(HB_HAS_PNG_LOCAL),)
      HB_LIBS_TPL += png
   endif


   # Create a few common core lib lists
   _HB_RDD := \
      hbrdd \
      rddntx \
      rddcdx \
      rddfpt \
      rddnsx \
      hbsix \
      hbhsx \
      hbusrrdd

   _HB_VM := hbvm
   HB_LIBS_ST_RDD := $(HB_LIBS_TPL)
   _HB_VM := hbvmmt
   HB_LIBS_MT_RDD := $(HB_LIBS_TPL)
   _HB_RDD := hbnulrdd
   _HB_VM := hbvm
   HB_LIBS_ST_NORDD := $(HB_LIBS_TPL)
   _HB_VM := hbvmmt
   HB_LIBS_MT_NORDD := $(HB_LIBS_TPL)

   # Cleanup temp vars
   HB_LIBS_TPL :=
   _HB_RDD :=
   _HB_VM :=

endif

HB_LINKING_RTL :=
HB_LINKING_VMMT :=

ifneq ($(filter hbrtl,$(LIBS)),)
   HB_LINKING_RTL := yes
   ifneq ($(filter hbvmmt,$(LIBS)),)
      HB_LINKING_VMMT := yes
   endif
endif

-include $(TOP)$(ROOT)config/$(HB_PLATFORM)/libs.mk

ifneq ($(__HB_BUILD_NOSYSLIB),)
   SYSLIBS := $(filter-out $(__HB_BUILD_NOSYSLIB),$(SYSLIBS))
endif

LIBS := $(HB_USER_LIBS) $(LIBS)

include $(TOP)$(ROOT)config/$(HB_PLATFORM)/$(HB_COMPILER).mk
include $(TOP)$(ROOT)config/c.mk
include $(TOP)$(ROOT)config/prg.mk
include $(TOP)$(ROOT)config/res.mk

BIN_NAME :=

ifneq ($(C_MAIN),)
   ifeq ($(BIN_NAME),)
      BIN_NAME := $(C_MAIN:.c=$(BIN_EXT))
   endif
endif

ifneq ($(PRG_MAIN),)
   ifeq ($(BIN_NAME),)
      BIN_NAME := $(PRG_MAIN:.prg=$(BIN_EXT))
   endif
endif

BIN_FILE := $(BIN_DIR)/$(BIN_NAME)

ALL_OBJS := $(ALL_C_OBJS) $(ALL_PRG_OBJS)
ifneq ($(RC),)
   ALL_OBJS += $(ALL_RC_OBJS)
endif

first:: dirbase descend curlLib libpqLib libSqlite3

descend:: dirbase
	+@$(MK) $(MKFLAGS) -C $(OBJ_DIR) -f $(GRANDP)Makefile TOP=$(GRANDP) $(BIN_NAME)

vpath $(BIN_NAME) $(BIN_DIR)
$(BIN_NAME) : $(ALL_OBJS)
	$(LD_RULE)

INSTALL_FILES := $(BIN_FILE)
INSTALL_DIR := $(HB_INSTALL_BIN)
include $(TOP)$(ROOT)config/instsh.mk
INSTALL_RULE_BIN := $(INSTALL_RULE)

ifneq ($(INSTALL_RULE_BIN),)

install:: first
	$(INSTALL_RULE_BIN)

endif

ifeq ($(HB_PLATFORM),win)
   SRCLIB3 := $(subst /,$(DIRSEP),$(HB_HAS_CURL)/../lib/libcurl_a.lib)
   DESTLIB3 := $(subst /,$(DIRSEP),$(LIB_DIR)/libcurl_a.lib)
   DESTDIR3 := $(subst /,$(DIRSEP),$(LIB_DIR)/lib)
else
   SRCLIB3 := $(subst /,$(DIRSEP),$(HB_HAS_CURL)../lib/libcurl.a)
   DESTLIB3 := $(subst /,$(DIRSEP),$(LIB_DIR)/libcurl.a)
   DESTDIR3 := $(subst /,$(DIRSEP),$(LIB_DIR))
endif

curlLib::
	$(if $(wildcard $(DESTDIR3)),,$(MD) $(DESTDIR3))
	$(if $(wildcard $(DESTLIB3)),,$(CP) $(SRCLIB3) $(DESTLIB3))


ifeq ($(HB_PLATFORM),win)

SRCLIB2 := $(subst /,$(DIRSEP),$(HB_HAS_POSTGRESQL)/../lib/libpq.lib)
DESTLIB2 := $(subst /,$(DIRSEP),$(LIB_DIR)/libpq.lib)
DESTDIR2 := $(subst /,$(DIRSEP),$(LIB_DIR)/lib)

else

SRCLIB2 := $(subst /,$(DIRSEP),$(HB_HAS_POSTGRESQL)../lib/libpq.a)
DESTLIB2 := $(subst /,$(DIRSEP),$(LIB_DIR)/libpq.a)
DESTDIR2 := $(subst /,$(DIRSEP),$(LIB_DIR))

endif

libpqLib::
	$(if $(wildcard $(DESTDIR2)),,$(MD) $(DESTDIR2))
	$(if $(wildcard $(DESTLIB2)),,$(CP) $(SRCLIB2) $(DESTLIB2))


ifeq ($(HB_PLATFORM),win)

SRCLIB4 := $(subst /,$(DIRSEP),$(HB_HAS_SQLITE3)/../lib/sqlite3.lib)
DESTLIB4 := $(subst /,$(DIRSEP),$(LIB_DIR)/libpq.lib)
DESTDIR4 := $(subst /,$(DIRSEP),$(LIB_DIR)/lib)

else

SRCLIB4 := $(subst /,$(DIRSEP),$(HB_HAS_SQLITE3)../lib/libsqlite3.a)
DESTLIB4 := $(subst /,$(DIRSEP),$(LIB_DIR)/libsqlite3.a)
DESTDIR4 := $(subst /,$(DIRSEP),$(LIB_DIR))


endif

libSqlite3::
	$(if $(wildcard $(DESTDIR4)),,$(MD) $(DESTDIR4))
	$(if $(wildcard $(DESTLIB4)),,$(CP) $(SRCLIB4) $(DESTLIB4))

