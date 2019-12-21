ROOT := ../../

include $(TOP)$(ROOT)config/global.mk

HB_PRGFLAGS += -gc3

PRG_SOURCES := \
   winapi/barcode.prg \
   winapi/drawwidg.prg \
   winapi/guimain.prg \
   winapi/hanimat.prg \
   winapi/hbincnt.prg \
   winapi/hbrowse.prg \
   winapi/hbrwflt.prg \
   winapi/hcheck.prg \
   winapi/hcombo.prg \
   winapi/hcontrol.prg \
   winapi/hcwindow.prg \
   winapi/hdatepic.prg \
   winapi/hdc.prg \
   winapi/hdialog.prg \
   winapi/hedit.prg \
   winapi/herrsys.prg \
   winapi/hfreeimg.prg \
   winapi/hfrmtmpl.prg \
   winapi/hgraph.prg \
   winapi/hgrid.prg \
   winapi/hhyper.prg \
   winapi/hipedit.prg \
   winapi/hlistbox.prg \
   winapi/hmonthc.prg \
   winapi/hnice.prg \
   winapi/hownbtn.prg \
   winapi/hpager.prg \
   winapi/hpanel.prg \
   winapi/hprinter.prg \
   winapi/hprogres.prg \
   winapi/hradio.prg \
   winapi/hrebar.prg \
   winapi/hrect.prg \
   winapi/hriched.prg \
   winapi/hsayimg.prg \
   winapi/hshbtn.prg \
   winapi/hsplash.prg \
   winapi/hsplit.prg \
   winapi/htab.prg \
   winapi/htimer.prg \
   winapi/htool.prg \
   winapi/htrackbr.prg \
   winapi/htree.prg \
   winapi/hupdown.prg \
   winapi/hwindow.prg \
   winapi/hwinprn.prg \
   winapi/menu.prg \
   winapi/printdos.prg \
   winapi/tmci.prg \
   winapi/video.prg \

C_SOURCES := \
   winapi/animat.c \
   winapi/commond.c \
   winapi/control.c \
   winapi/cxshade.c \
   winapi/c_ipaddr.c \
   winapi/dialog.c \
   winapi/draw.c \
   winapi/drawtext.c \
   winapi/freeimg.c \
   winapi/grid.c \
   winapi/listbox.c \
   winapi/media_c.c \
   winapi/menu_c.c \
   winapi/message.c \
   winapi/misc.c \
   winapi/nice.c \
   winapi/pager.c \
   winapi/registry.c \
   winapi/resource.c \
   winapi/richedit.c \
   winapi/shellapi.c \
   winapi/window.c \
   winapi/winreg.c \
   winapi/wprint.c \

LIBNAME := hwgui


ifneq ($(HB_HAS_ZLIB),)

   HB_CFLAGS += $(QUOTE)-I$(HB_HAS_ZLIB)$(QUOTE)
   include $(TOP)$(ROOT)config/lib.mk
   include $(TOP)$(ROOT)config/dir.mk
else
   $(error ! Error: zlib component required [hwgui], but not available)
endif

