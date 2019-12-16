ROOT := ../../

include $(TOP)$(ROOT)config/global.mk

HB_PRGFLAGS += -gc3

C_SOURCES := \
   annot.c \
   core.c \
   enccns.c \
   enccnt.c \
   encjp.c \
   enckr.c \
   font.c \
   fontcns.c \
   fontcnt.c \
   fontjp.c \
   fontkr.c \
   image.c \
   pdfa.c \

PRG_SOURCES := \
   errstr.prg \
   misc.prg \

LIBNAME := hbhpdf



ifneq ($(HB_HAS_ZLIB),)

   ifneq ($(HB_HAS_ZLIB),)
      HB_CFLAGS += -DHB_HAS_ZLIB $(QUOTE)-I$(HB_HAS_ZLIB)$(QUOTE)
   endif
   ifneq ($(HB_HAS_PNG),)
      HB_CFLAGS += -DHB_HAS_PNG
   endif
   ifneq ($(HB_HAS_HARUPDF),)
      HB_CFLAGS += -DHB_HAS_HARUPDF $(QUOTE)-I$(HB_HAS_HARUPDF)$(QUOTE)
   endif


   include $(TOP)$(ROOT)config/lib.mk
   include $(TOP)$(ROOT)config/dir.mk
else
   $(error ! Error: zlib component required, but not available)
endif

