ROOT := ../../

include $(TOP)$(ROOT)config/global.mk

LIBNAME := harupdf

HB_BUILD_WARN := no
HB_BUILD_MODE := c


C_SOURCES := \
   _hb_hpdf.c \
   hpdf_3dmeasure.c \
   hpdf_annotation.c \
   hpdf_array.c \
   hpdf_binary.c \
   hpdf_boolean.c \
   hpdf_catalog.c \
   hpdf_destination.c \
   hpdf_dict.c \
   hpdf_doc.c \
   hpdf_doc_png.c \
   hpdf_encoder.c \
   hpdf_encoder_cns.c \
   hpdf_encoder_cnt.c \
   hpdf_encoder_jp.c \
   hpdf_encoder_kr.c \
   hpdf_encoder_utf.c \
   hpdf_encrypt.c \
   hpdf_encryptdict.c \
   hpdf_error.c \
   hpdf_exdata.c \
   hpdf_ext_gstate.c \
   hpdf_font.c \
   hpdf_font_cid.c \
   hpdf_fontdef_base14.c \
   hpdf_fontdef.c \
   hpdf_fontdef_cid.c \
   hpdf_fontdef_cns.c \
   hpdf_fontdef_cnt.c \
   hpdf_fontdef_jp.c \
   hpdf_fontdef_kr.c \
   hpdf_fontdef_tt.c \
   hpdf_fontdef_type1.c \
   hpdf_font_tt.c \
   hpdf_font_type1.c \
   hpdf_gstate.c \
   hpdf_image.c \
   hpdf_image_ccitt.c \
   hpdf_image_png.c \
   hpdf_info.c \
   hpdf_list.c \
   hpdf_mmgr.c \
   hpdf_name.c \
   hpdf_namedict.c \
   hpdf_null.c \
   hpdf_number.c \
   hpdf_objects.c \
   hpdf_outline.c \
   hpdf_page_label.c \
   hpdf_page_operator.c \
   hpdf_pages.c \
   hpdf_pdfa.c \
   hpdf_real.c \
   hpdf_streams.c \
   hpdf_string.c \
   hpdf_u3d.c \
   hpdf_utils.c \
   hpdf_xref.c \

ifneq ($(HB_HAS_HARUPDF_LOCAL),)
   HB_CFLAGS += $(QUOTE)-I$(HB_HAS_PNG)$(QUOTE)
   include $(TOP)$(ROOT)config/lib.mk

else
   HB_SKIP_REASON := local copy unused
   include $(TOP)$(ROOT)config/none.mk
endif


