ROOT := ../../

include $(TOP)$(ROOT)config/global.mk

HB_PRGFLAGS += -gc3

C_SOURCES := \
   date.c \
   easy.c \
   escold.c \
   global.c \
   miscc.c \
   ver.c \

PRG_SOURCES := \
   misc.prg \

LIBNAME := hbcurl

HB_CFLAGS += -DHB_HAS_CURL $(QUOTE)-I$(HB_HAS_CURL)$(QUOTE)

#HB_CFLAGS += -I$(HB_HOST_INC)/openssl
#ifeq ($(HB_PLATFORM),win)
#      HB_CFLAGS += -I$(HB_HOST_INC)/openssl/port/win32
#endif

include $(TOP)$(ROOT)config/lib.mk

