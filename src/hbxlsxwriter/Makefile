ROOT := ../../

include $(TOP)$(ROOT)config/global.mk

HB_PRGFLAGS += -gc3

C_SOURCES := \
   app.c \
   chart.c \
   chartsheet.c \
   content_types.c \
   core.c \
   custom.c \
   drawing.c \
   format.c \
   hb_misc.c \
   relationships.c \
   shared_strings.c \
   styles.c \
   theme.c \
   utility.c \
   workbook.c \
   worksheet.c \

PRG_SOURCES := \
   hb_others.prg \

LIBNAME := hbxlsxwriter


ifneq ($(HB_HAS_ZLIB),)

   ifneq ($(HB_HAS_ZLIB),)
      HB_CFLAGS += -DHB_HAS_ZLIB $(QUOTE)-I$(HB_HAS_ZLIB)$(QUOTE)
   endif

   include $(TOP)$(ROOT)config/lib.mk
   include $(TOP)$(ROOT)config/dir.mk
else
   $(error ! Error: zlib component required, but not available)
endif

