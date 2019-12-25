ROOT := ../../

include $(TOP)$(ROOT)config/global.mk

HB_PRGFLAGS += -gc3

C_SOURCES := \
   core.c \

LIBNAME := sddsqlt3

HB_CFLAGS += -DHB_HAS_SQLITE3 $(QUOTE)-I$(HB_HAS_SQLITE3)$(QUOTE)

ifneq ($(HB_HAS_ZLIB),)
   HB_CFLAGS += $(QUOTE)-I$(HB_HAS_ZLIB)$(QUOTE)
   include $(TOP)$(ROOT)config/lib.mk
   include $(TOP)$(ROOT)config/dir.mk
else
   $(error ! Error: zlib [sddsqlt3] component required, but not available)
endif

