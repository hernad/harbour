/*
 * Generated by util/mkerr.pl DO NOT EDIT
 * Copyright 1995-2018 The OpenSSL Project Authors. All Rights Reserved.
 *
 * Licensed under the OpenSSL license (the "License").  You may not use
 * this file except in compliance with the License.  You can obtain a copy
 * in the file LICENSE in the source distribution or at
 * https://www.openssl.org/source/license.html
 */

#include <stdio.h>
#include <openssl/err.h>
#include <openssl/conf.h>

/* BEGIN ERROR CODES */
#ifndef OPENSSL_NO_ERR

# define ERR_FUNC(func) ERR_PACK(ERR_LIB_CONF,func,0)
# define ERR_REASON(reason) ERR_PACK(ERR_LIB_CONF,0,reason)

static ERR_STRING_DATA CONF_str_functs[] = {
    {ERR_FUNC(CONF_F_CONF_DUMP_FP), "CONF_dump_fp"},
    {ERR_FUNC(CONF_F_CONF_LOAD), "CONF_load"},
    {ERR_FUNC(CONF_F_CONF_LOAD_FP), "CONF_load_fp"},
    {ERR_FUNC(CONF_F_CONF_PARSE_LIST), "CONF_parse_list"},
    {ERR_FUNC(CONF_F_DEF_LOAD), "def_load"},
    {ERR_FUNC(CONF_F_DEF_LOAD_BIO), "def_load_bio"},
    {ERR_FUNC(CONF_F_MODULE_INIT), "module_init"},
    {ERR_FUNC(CONF_F_MODULE_LOAD_DSO), "module_load_dso"},
    {ERR_FUNC(CONF_F_MODULE_RUN), "module_run"},
    {ERR_FUNC(CONF_F_NCONF_DUMP_BIO), "NCONF_dump_bio"},
    {ERR_FUNC(CONF_F_NCONF_DUMP_FP), "NCONF_dump_fp"},
    {ERR_FUNC(CONF_F_NCONF_GET_NUMBER_E), "NCONF_get_number_e"},
    {ERR_FUNC(CONF_F_NCONF_GET_SECTION), "NCONF_get_section"},
    {ERR_FUNC(CONF_F_NCONF_GET_STRING), "NCONF_get_string"},
    {ERR_FUNC(CONF_F_NCONF_LOAD), "NCONF_load"},
    {ERR_FUNC(CONF_F_NCONF_LOAD_BIO), "NCONF_load_bio"},
    {ERR_FUNC(CONF_F_NCONF_LOAD_FP), "NCONF_load_fp"},
    {ERR_FUNC(CONF_F_NCONF_NEW), "NCONF_new"},
    {ERR_FUNC(CONF_F_SSL_MODULE_INIT), "ssl_module_init"},
    {ERR_FUNC(CONF_F_STR_COPY), "str_copy"},
    {0, NULL}
};

static ERR_STRING_DATA CONF_str_reasons[] = {
    {ERR_REASON(CONF_R_ERROR_LOADING_DSO), "error loading dso"},
    {ERR_REASON(CONF_R_LIST_CANNOT_BE_NULL), "list cannot be null"},
    {ERR_REASON(CONF_R_MISSING_CLOSE_SQUARE_BRACKET),
     "missing close square bracket"},
    {ERR_REASON(CONF_R_MISSING_EQUAL_SIGN), "missing equal sign"},
    {ERR_REASON(CONF_R_MISSING_INIT_FUNCTION), "missing init function"},
    {ERR_REASON(CONF_R_MODULE_INITIALIZATION_ERROR),
     "module initialization error"},
    {ERR_REASON(CONF_R_NO_CLOSE_BRACE), "no close brace"},
    {ERR_REASON(CONF_R_NO_CONF), "no conf"},
    {ERR_REASON(CONF_R_NO_CONF_OR_ENVIRONMENT_VARIABLE),
     "no conf or environment variable"},
    {ERR_REASON(CONF_R_NO_SECTION), "no section"},
    {ERR_REASON(CONF_R_NO_SUCH_FILE), "no such file"},
    {ERR_REASON(CONF_R_NO_VALUE), "no value"},
    {ERR_REASON(CONF_R_SSL_COMMAND_SECTION_EMPTY),
     "ssl command section empty"},
    {ERR_REASON(CONF_R_SSL_COMMAND_SECTION_NOT_FOUND),
     "ssl command section not found"},
    {ERR_REASON(CONF_R_SSL_SECTION_EMPTY), "ssl section empty"},
    {ERR_REASON(CONF_R_SSL_SECTION_NOT_FOUND), "ssl section not found"},
    {ERR_REASON(CONF_R_UNABLE_TO_CREATE_NEW_SECTION),
     "unable to create new section"},
    {ERR_REASON(CONF_R_UNKNOWN_MODULE_NAME), "unknown module name"},
    {ERR_REASON(CONF_R_VARIABLE_EXPANSION_TOO_LONG),
     "variable expansion too long"},
    {ERR_REASON(CONF_R_VARIABLE_HAS_NO_VALUE), "variable has no value"},
    {0, NULL}
};

#endif

int ERR_load_CONF_strings(void)
{
#ifndef OPENSSL_NO_ERR

    if (ERR_func_error_string(CONF_str_functs[0].error) == NULL) {
        ERR_load_strings(0, CONF_str_functs);
        ERR_load_strings(0, CONF_str_reasons);
    }
#endif
    return 1;
}
