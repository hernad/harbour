ROOT := ../../

include $(TOP)$(ROOT)config/global.mk

LIBNAME := png

HB_BUILD_WARN := no
HB_BUILD_MODE := c

C_SOURCES := \
   png.c \
   pngerror.c \
   pngget.c \
   pngmem.c \
   pngpread.c \
   pngread.c \
   pngrio.c \
   pngrtran.c \
   pngrutil.c \
   pngset.c \
   pngtrans.c \
   pngwio.c \
   pngwrite.c \
   pngwtran.c \
   pngwutil.c \


ifneq ($(HB_HAS_ZLIB),)

   HB_CFLAGS += $(QUOTE)-I$(HB_HAS_ZLIB)$(QUOTE)
   HB_CFLAGS_DYN := -DPNG_BUILD_DLL

   include $(TOP)$(ROOT)config/lib.mk
else
   HB_SKIP_REASON := $(_DET_RES_TEXT)
   include $(TOP)$(ROOT)config/none.mk
endif


# URL    https://download.sourceforge.net/libpng/libpng-1.6.34.tar.xz
# DIFF   png.diff
#
# MAP    LICENSE
# MAP    png.c
# MAP    pngconf.h
# MAP    scripts/pnglibconf.h.prebuilt  pnglibconf.h
# MAP    pngerror.c
# MAP    pngget.c
# MAP    png.h
# MAP    pngmem.c
# MAP    pngpread.c
# MAP    pngpriv.h
# MAP    pngread.c
# MAP    pngrio.c
# MAP    pngrtran.c
# MAP    pngrutil.c
# MAP    pngset.c
# MAP    pngtrans.c
# MAP    pngwio.c
# MAP    pngwrite.c
# MAP    pngwtran.c
# MAP    pngwutil.c
# MAP    pnginfo.h
# MAP    pngstruct.h
# MAP    pngdebug.h
