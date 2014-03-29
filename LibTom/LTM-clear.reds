Red/System [
	Purpose:	"Clears a mp-int freeing the memory used for digits"
	Author:		"Peter W A Wood"
	Version:	0.1.0
	License:	{See https://github.com/red/red/blob/master/system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-clear: func [
	"Clears a mp-int freeing the memory used for digits"
	mp-int			[LTM-int!]			"The integer to be cleared"
	return:			[integer!]			"LTM-OKAY or an error code"		
][
	
	;; check if the integer has already been cleared
	if mp-int/mp-digit = as LTM-digit-ptr! 0 [return LTM-INVALID]
	
	;; zero the digits before releasing the memory in case the user has
	;; mistakenly stored the address of the digits 
	if mp-int/used > 0 [
		LTM-zero-set(mp-int/mp-digit 1 mp-int/used)
	]

	;; free the memory
	free mp-int/mp-digit
	
	;; reset the structure members
	mp-int/mp-digit: as LTM-digit-ptr! 0
	mp-int/alloc: 0
	mp-int/used: 0
	mp-int/sign: LTM-ZPOS
	
	LTM-OKAY
	
]