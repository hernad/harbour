/* NOTE: This file is also used by Harbour .prg code. */

#ifndef HB_VER_H_
#define HB_VER_H_

#ifdef __HARBOUR__
   #undef __HARBOUR__
#endif

#define HB_VER_MAJOR    4        /* Major version number */
#define HB_VER_MINOR    4        /* Minor version number */
#define HB_VER_RELEASE  0        /* Release number */
#define HB_VER_STATUS   "hernad"    /* Build status (all lowercase) */
#define __HARBOUR__     0x040400 /* Three bytes: Major + Minor + Release. This is recommented for 3rd party .c and .prg level code. */

#endif /* HB_VER_H_ */
