ROOT := ../../

include $(TOP)$(ROOT)config/global.mk

HB_PRGFLAGS += -gc3

C_SOURCES := \
   hblibpq.c \
   rddcopy.c \


PRG_SOURCES := \
   tpostgre.prg \

LIBNAME := hbpgsql

# HB_CFLAGS += -I$(HB_HOST_INC)/postgres
HB_CFLAGS += -DHB_HAS_POSTGRESQL $(QUOTE)-I$(HB_HAS_POSTGRESQL)$(QUOTE)

ifneq ($(HB_HAS_ZLIB),)

   HB_CFLAGS += $(QUOTE)-I$(HB_HAS_ZLIB)$(QUOTE)
   
   include $(TOP)$(ROOT)config/lib.mk
   include $(TOP)$(ROOT)config/dir.mk
else
   $(error ! Error: zlib [hbpgsql] component required, but not available)
endif

