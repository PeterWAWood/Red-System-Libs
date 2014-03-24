Red/System [
  Purpose:	"Initalises a new mp-int (multiple-precision integer)"
  Author:	"PeterWAWood"
  Version:	0.1.0
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-init: func [
	"Initalises a new mp-int (multiple-precision integer)"
	mp-int			        [LTM-int!]				      "The integer to be intialised"
	return:			        [integer!]				      "LTM-OKAY or an error code"			
][

	;; allocate the memory
	mp-int/mp-digit: allocate  LTM-PREC
	
	;; return memory error if memory not allocated
	if mp-int/mp-digit = as LTM-digit-ptr! 0 [return LTM-MEM]
	
	;; set the digits to zero
	LTM-zero-set(mp-int/mp-digit 1 LTM-PREC)
	
	;; set the used to zero, allocated digits to the default precision
	;; and sign to positive	
	mp-int/used: 0
	mp-int/alloc: LTM-PREC
	mp-int/sign: LTM-ZPOS
	LTM-OKAY
	
]