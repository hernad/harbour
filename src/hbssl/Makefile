ROOT := ../../

include $(TOP)$(ROOT)config/global.mk

HB_PRGFLAGS += -gc3

C_SOURCES := \
   bio.c \
   err.c \
   evp.c \
   evpciph.c \
   evpenc.c \
   evpmd.c \
   evppkey.c \
   pem.c \
   rand.c \
   ssl.c \
   sslciph.c \
   sslctx.c \
   ssl_hb.c \
   ssl_inet.c \
   sslsess.c \
   ssl_sock.c \
   x509.c \

PRG_SOURCES := \
   ssl_hbcon.prg \

LIBNAME := hbssl

include $(TOP)$(ROOT)config/lib.mk

