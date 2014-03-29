Red/System [
  Purpose:	"Multiple-precision integer library"
  Author:	"PeterWAWood"
  Version:	0.1.0
  File:		%libtommaths.reds		 
  Descripton:	"A reduced implementation of LibTomMath authored by Tom St Denis"
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

#include %LTM-abs.reds
#include %LTM-add.reds
#include %LTM-clamp.reds
#include %LTM-clear.reds
#include %LTM-cmp.reds
#include %LTM-cmp-mag.reds
#include %LTM-copy.reds
#include %LTM-copy-init.reds
#include %LTM-div-2.reds
#include %LTM-div-2d.reds
#include %LTM-grow.reds
#include %LTM-init.reds
#include %LTM-init-multi.reds
#include %LTM-init-size.reds
#include %LTM-lshd.reds
#include %LTM-mod-2d.reds
#include %LTM-mul-2.reds
#include %LTM-mul-2d.reds
#include %LTM-negate.reds
#include %LTM-rshd.reds
#include %LTM-set.reds
#include %LTM-set-int.reds
#include %LTM-sub.reds
#include %LTM-s-add.reds
#include %LTM-s-mul-digs.reds
#include %LTM-s-sub.reds
#include %LTM-zero.reds
