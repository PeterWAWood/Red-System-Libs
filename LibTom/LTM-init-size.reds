Red/System [
	Purpose:	"Initalises a new mp-int (multiple-precision integer) to a given size"
	Author:		"Peter W A Wood"
	Version:	0.1.0
	License:	{https://github.com/red/red/blob/master/BSL-License.txt}
]

#include %libtommaths.def

LTM-init-size: func [
	"Initalises a new mp-int (multiple-precision integer) to a given size"
	mp-int				[LTM-int!]				"The integer to be intialised"
	size				[integer!]				"Minimum number of digits"
	return:				[integer!]				"LTM-OKAY or an error code"		
][
	
	;; ensure that there are always at least LTM-PREC digits empty 
	LTM-pad-size(size)
	
	;; allocate the memory
	mp-int/mp-digit: allocate  size
	
	;; return memory error if memory not allocated
	if mp-int/mp-digit = as LTM-digit-ptr! 0 [return LTM-MEM]
	
	;; set the digits to zero
	LTM-zero-set(mp-int/mp-digit 1 LTM-PREC)
	
	;; set the used to zero, allocated digits to the default precision
	;; and sign to positive	
	mp-int/used: 0
	mp-int/alloc: 2 * LTM-PREC
	mp-int/sign: LTM-ZPOS
	LTM-OKAY
]
