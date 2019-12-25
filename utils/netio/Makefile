ROOT := ../../

include $(TOP)$(ROOT)config/global.mk

PRG_SOURCES := \
   netio_console.prg \
   netio_management.prg \
   netio.prg \

PRG_MAIN := netio.prg

ifeq ($(HB_PLATFORM),win)
   PRG_SOURCES += netio_service.prg
else
   PRG_SOURCES += netio_daemon.prg
endif

# ne kontam
LIBS = $(HB_LIBS_MT_RDD)

ifeq ($(HB_PLATFORM),win)
   HB_USER_LIBS := hbwin -hbnetio
else
   HB_USER_LIBS := hbunix hbnetio
endif

include $(TOP)$(ROOT)config/bin.mk

#$(info "=================LIBS: $(LIBS) =============")

HB_PRGFLAGS += -u -i$(TOP)
HB_RCFLAGS += -D_HB_INCLUDE_ICON

ifneq ($(filter $(HB_COMPILER),gcc mingw mingw64 clang clang64),)
   HB_USER_CFLAGS := $(filter-out -flto,$(HB_USER_CFLAGS))
   HB_LDFLAGS += -fno-lto
endif
