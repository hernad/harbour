ROOT := ../

include $(TOP)$(ROOT)config/global.mk

ifeq ($(HB_BUILD_PARTS),compiler)

   DIRS := \
      common \
      nortl \
      pp{common,nortl} \
      compiler{pp} \
      main{compiler} \

else

   ifneq ($(__HB_BUILD_DYN),no)

      DYNDIRLIST_BASE := \
         src/common \
         src/pp \
         src/rtl \
         src/macro \
         src/lang \
         src/codepage \
         src/hbextern \
         src/rdd \
         src/rdd/dbfntx \
         src/rdd/dbfnsx \
         src/rdd/dbfcdx \
         src/rdd/dbffpt \
         src/rdd/hbsix \
         src/rdd/hsx \
         src/rdd/usrrdd \
         src/rtl/gtstd \
         src/rtl/gtcgi 

      ifeq ($(HB_PLATFORM),win)
         DYNDIRLIST_BASE += src/rtl/gtwvt src/rtl/gtgui src/rtl/gtwin
      endif
      ifneq ($(HB_PLATFORM_UNIX),)
         DYNDIRLIST_BASE += src/rtl/gttrm
         ifneq ($(HB_HAS_X11),)
            DYNDIRLIST_BASE += src/rtl/gtxwc
         endif
      endif

      ifneq ($(HB_HAS_PCRE2_LOCAL),)
         DYNDIRLIST_BASE += src/3rd/pcre2
      else
      endif
      ifneq ($(HB_HAS_ZLIB_LOCAL),)
         DYNDIRLIST_BASE += src/3rd/zlib
      endif

      export DYNDIRLIST_BASE
   endif

   ifeq ($(HB_BUILD_PARTS),lib)
      HB_COMP_DIR :=
      HB_COMP_REF :=
      HB_COMP_RF2 := {compiler}
   else
      HB_COMP_DIR := main{compiler}
      HB_COMP_REF := {main}
      HB_COMP_RF2 := {main}
   endif

   DIRS := \
      3rd \
      common \
      nortl \
      pp{common,nortl} \
      compiler{pp} \
      $(HB_COMP_DIR) \
      vm$(HB_COMP_RF2) \
      rtl$(HB_COMP_REF) \
      macro \
      codepage \
      lang \
      rdd$(HB_COMP_REF) \
      hbextern$(HB_COMP_REF) \
      debug$(HB_COMP_REF)

      ifneq ($(__HB_BUILD_DYN),no)
         DIRS += dynlib{3rd,codepage,common,hbextern,lang,macro,pp,rdd,rtl,vm}
      endif

endif

include $(ROOT)config/dir.mk
