ROOT := ../../

include $(TOP)$(ROOT)config/global.mk

LIBNAME := pq

HB_BUILD_WARN := no
HB_BUILD_MODE := c

# fe-gssapi-common.c
# fe-secure-gssapi.c

C_SOURCES := \
    fe-auth-scram.c \
    fe-auth.c \
    fe-connect.c \
    fe-exec.c \
    fe-lobj.c \
    fe-print.c \
    fe-protocol2.c \
    fe-protocol3.c \
    fe-secure-common.c \
    fe-secure-openssl.c \
    fe-secure.c \
    legacy-pqsignal.c \
    libpq-events.c \
    pqexpbuffer.c \
    pthread-win32.c \
    win32.c \
    

ifneq ($(HB_HAS_PQ_LOCAL),)

   HB_CFLAGS += -DWIN32 -DUSE_OPENSSL
   #-DUSE_SSL
   #-DUSE_SSL_ENGINE
   # -DENABLE_SSPI 
   #-DENABLE_GSS
   HB_CFLAGS += -I$(HB_HOST_INC)/postgres
   HB_CFLAGS += -I$(HB_HOST_INC)/openssl

   ifeq ($(HB_PLATFORM),win)
      HB_CFLAGS += -I$(HB_HOST_INC)/postgres/port/win32

      #HB_CFLAGS += /link /LIBPATH:$(TOP)$(ROOT)\binary\lib\win32
   endif

   

   HB_CFLAGS += -DUSE_STANDARD_TMPFILE
   HB_CFLAGS += $(QUOTE)-I$(HB_HAS_ZLIB)$(QUOTE)
   HB_CFLAGS += $(QUOTE)-I$(HB_HAS_PNG)$(QUOTE)
   HB_CFLAGS += $(QUOTE)-I$(HB_HAS_MINIZIP)$(QUOTE)
   HB_CFLAGS += $(QUOTE)-I$(HB_HAS_XLSWRITER)$(QUOTE)
   include $(TOP)$(ROOT)config/lib.mk
else
    HB_SKIP_REASON := libpq local copy unused
    include $(TOP)$(ROOT)config/none.mk
endif
