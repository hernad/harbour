ROOT := ../../

include $(TOP)$(ROOT)config/global.mk

PRG_SOURCES := \
   hbformat.prg \
   hbfmtcls.prg \
   hbfuncs.prg \

PRG_MAIN := hbformat.prg

LIBS = $(HB_LIBS_MT_RDD)

HB_PRGFLAGS += -u -i$(TOP)
HB_RCFLAGS += -D_HB_INCLUDE_ICON

include $(TOP)$(ROOT)config/bin.mk

ifneq ($(filter $(HB_COMPILER),gcc mingw mingw64 clang clang64),)
   HB_USER_CFLAGS := $(filter-out -flto,$(HB_USER_CFLAGS))
   HB_LDFLAGS += -fno-lto
endif
