ROOT := ../../

include $(TOP)$(ROOT)config/global.mk

LIBNAME := minizip

HB_BUILD_WARN := no
HB_BUILD_MODE := c

C_SOURCES := \
   ioapi.c \
   unzip.c \
   zip.c \

ifneq ($(HB_HAS_MINIZIP_LOCAL),)
   HB_CFLAGS += $(QUOTE)-I$(HB_HAS_ZLIB)$(QUOTE)
   include $(TOP)$(ROOT)config/lib.mk
else
   HB_SKIP_REASON := minizip local copy unused
   include $(TOP)$(ROOT)config/none.mk
endif
