ROOT := ../../

include $(TOP)$(ROOT)config/global.mk

HB_PRGFLAGS += -gc3

C_SOURCES := \
   postgres.c \
   rddcopy.c \


PRG_SOURCES := \
   tpostgre.prg \

LIBNAME := hbpgsql


ifneq ($(HB_HAS_ZLIB),)

   ifneq ($(HB_HAS_ZLIB),)
      HB_CFLAGS += -DHB_HAS_ZLIB $(QUOTE)-I$(HB_HAS_ZLIB)$(QUOTE)
   endif

   include $(TOP)$(ROOT)config/lib.mk
   include $(TOP)$(ROOT)config/dir.mk
else
   $(error ! Error: zlib component required, but not available)
endif

