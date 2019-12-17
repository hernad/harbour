ROOT := ../../

include $(TOP)$(ROOT)config/global.mk

LIBNAME := xlsxwriter

HB_BUILD_WARN := no
HB_BUILD_MODE := c

C_SOURCES := \
    app.c \
    chart.c \
    chartsheet.c \
    content_types.c \
    core.c \
    custom.c \
    drawing.c \
    format.c \
    hash_table.c \
    packager.c \
    relationships.c \
    shared_strings.c \
    styles.c \
    theme.c \
    utility.c \
    workbook.c \
    worksheet.c \
    xmlwriter.c \


ifneq ($(HB_HAS_XLSWRITER_LOCAL),)
   HB_CFLAGS += -DUSE_STANDARD_TMPFILE
   HB_CFLAGS += $(QUOTE)-I$(HB_HAS_ZLIB)$(QUOTE)
   HB_CFLAGS += $(QUOTE)-I$(HB_HAS_PNG)$(QUOTE)
   HB_CFLAGS += $(QUOTE)-I$(HB_HAS_MINIZIP)$(QUOTE)
   HB_CFLAGS += $(QUOTE)-I$(HB_HAS_XLSWRITER)$(QUOTE)
   include $(TOP)$(ROOT)config/lib.mk
else
    HB_SKIP_REASON := xlsxwriter local copy unused
    include $(TOP)$(ROOT)config/none.mk
endif
