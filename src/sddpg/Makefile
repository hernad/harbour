ROOT := ../../

include $(TOP)$(ROOT)config/global.mk

HB_PRGFLAGS += -gc3

C_SOURCES := \
   core.c \

LIBNAME := sddpg

#HB_CFLAGS += -I$(HB_HOST_INC)/postgres
HB_CFLAGS += -DHB_HAS_POSTGRESQL $(QUOTE)-I$(HB_HAS_POSTGRESQL)$(QUOTE)

include $(TOP)$(ROOT)config/lib.mk
include $(TOP)$(ROOT)config/dir.mk


