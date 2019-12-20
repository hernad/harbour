ROOT := ../../

include $(TOP)$(ROOT)config/global.mk

HB_PRGFLAGS += -gc3

C_SOURCES := \
   core.c \

LIBNAME := sddpg

#HB_CFLAGS += -I$(HB_HOST_INC)/postgres
HB_CFLAGS += -DHB_WITH_PGSQL $(QUOTE)-I$(HB_WITH_PGSQL)$(QUOTE)

include $(TOP)$(ROOT)config/lib.mk
include $(TOP)$(ROOT)config/dir.mk


