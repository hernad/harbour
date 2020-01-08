ROOT := ../

include $(TOP)$(ROOT)config/global.mk




   #ifeq ($(HB_BUILD_PARTS),lib)
   #   HB_COMP_DIR :=
   #   HB_COMP_REF :=
   #   HB_COMP_RF2 := {compiler}
   #else
      HB_COMP_DIR := main{compiler}
      HB_COMP_REF := {main}
      HB_COMP_RF2 := {main}
   #endif

   DIRS := \
      3rd \
      common \
      nortl \
      pp{common,nortl} \
      compiler{pp} \
      main{compiler} \
      vm{main} \
      rtl{main} \
      macro \
      codepage \
      lang \
      rdd{main} \
      hbextern{main} \
      hbhpdf{main} \
      debug{main} \
      hbpgsql \
      sddpg \
      hbmzip \
      hbxlsxwriter \
      hbssl \
      hbtip \
      hbct \
      hbcurl \
      hbsqlite3 \
      sddsqlt3 \
      hbtest \
      hbnetio \

      ifeq ($(HB_HOST_PLAT),win)
         DIRS += hbwin
      else
         DIRS += hbunix
      endif



include $(ROOT)config/dir.mk
