ROOT := ../../

include $(TOP)$(ROOT)config/global.mk

HB_PRGFLAGS += -gc3

C_SOURCES := \
   netiocli.c \
   netiosrv.c \

PRG_SOURCES := \
   netiomt.prg\

LIBNAME := hbnetio

#HB_CFLAGS += -DHB_HAS_CURL $(QUOTE)-I$(HB_HAS_CURL)$(QUOTE)

include $(TOP)$(ROOT)config/lib.mk

