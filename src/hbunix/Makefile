ROOT := ../../

include $(TOP)$(ROOT)config/global.mk

ifneq ($(HB_HOST_PLAT),win)

HB_PRGFLAGS += -gc3

C_SOURCES := \
	chdir.c \
	chown.c \
	chroot.c \
	daemon.c \
	posix.c \
	posixerr.c \
	sleep.c \
	uidgid.c \

PRG_SOURCES := \
	linux.prg \


LIBNAME := hbunix

include $(TOP)$(ROOT)config/lib.mk

else
   $(error Error: !unix platform)
endif
