/*
 * VMS::Stat.xs - VMS extensions to stat.h
 * 
 * Version  0.01
 * Peter Prymmer
 * Revision: 26-APR-2004
 */

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <libdef.h> /* LIB$_INVARG */

#include "ppport.h"

#include <stat.h>


MODULE = VMS::Stat		PACKAGE = VMS::Stat		

void
vmsmkdir(dir_spec,...)
	char * dir_spec
	PROTOTYPE: @
	CODE:
	    mode_t mode;
	    mode_t default_mode = 0777;
	    unsigned int uic;
	    unsigned short max_versions;
	    unsigned short r_v_number;
	    int rc;

	    if (!dir_spec || !*dir_spec) {
	        SETERRNO(EINVAL,LIB$_INVARG);
	        XSRETURN_UNDEF;
	    }
	    if (items > 5) croak("too many args");

	    /* This hack stolen right out of vmsopen() */
	    switch (items) {
              case 1:
                rc = mkdir(dir_spec,default_mode);
                break;
              case 2:
	        mode = (mode_t)SvIV(ST(1));
                rc = mkdir(dir_spec,mode);
                break;
              case 3:
	        mode = (mode_t)SvIV(ST(1));
	        uic = (unsigned int)SvIV(ST(2));
                rc = mkdir(dir_spec,mode,uic);
                break;
              case 4:
	        mode = (mode_t)SvIV(ST(1));
	        uic = (unsigned int)SvIV(ST(2));
	        max_versions = (unsigned short)SvIV(ST(3));
                rc = mkdir(dir_spec,mode,uic,max_versions);
                break;
              case 5:
	        mode = (mode_t)SvIV(ST(1));
	        uic = (unsigned int)SvIV(ST(2));
	        max_versions = (unsigned short)SvIV(ST(3));
	        r_v_number = (unsigned short)SvIV(ST(4));
                rc = mkdir(dir_spec,mode,uic,max_versions,r_v_number);
                break;
	    }
	    ST(0) = (rc == 0) ?  &PL_sv_yes : &PL_sv_undef;
