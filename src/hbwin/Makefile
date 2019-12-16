ROOT := ../../

include $(TOP)$(ROOT)config/global.mk

ifeq ($(HB_HOST_PLAT),win)

HB_PRGFLAGS += -gc3

C_SOURCES := \
	axcore.c \
	hbolesrv.c \
	mapi.c \
	oemansi.c \
	olecore.c \
	oleuuid.c \
	wapi_alloc.c \
	wapi_commctrl.c \
	wapi_err.c \
	wapi_misc.c \
	wapi_mmsystem.c \
	wapi_secur32.c \
	wapi_shellapi.c \
	wapi_winbase_1.c \
	wapi_winbase_2.c \
	wapi_winbase_mutex.c \
	wapi_wingdi.c \
	wapi_wingdi_font.c \
	wapi_winnetwk.c \
	wapi_winnls.c \
	wapi_winuser_1.c \
	wapi_winuser_2.c \
	wapi_winuser_dlg.c \
	wce_simc.c \
	wce_smsc.c \
	win_bmp.c \
	win_bmpd.c \
	win_com.c \
	win_commdlg.c \
	win_dlg.c \
	win_evnt.c \
	win_misc_1.c \
	win_misc_2.c \
	win_osc.c \
	win_prn1.c \
	win_prn2.c \
	win_prn3.c \
	win_proxyc.c \
	win_regc.c \
	win_rpc.c \
	win_shell.c \
	win_svc_1.c \
	win_svc_2.c \

PRG_SOURCES := \
	axfunc.prg \
	oleauto.prg \
	wce_sim.prg \
	win_err.prg \
	win_os.prg \
	win_proxy.prg \
	win_reg.prg \
	win_tbmp.prg \
	win_tcom.prg \
	win_tprn.prg \

LIBNAME := hbwin

include $(TOP)$(ROOT)config/lib.mk

else
   $(error Error: !windows platform)
endif
