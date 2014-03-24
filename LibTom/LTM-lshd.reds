Red/System [
  Purpose:	"Shift left a number of digits"
  Author:	"PeterWAWood"
  Version:	0.1.0
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-lshd: func [
	"Shift left a number of digits"
	mp-int			      [LTM-int!]				"The integer to be left shifted"
	shift			        [integer!]				"Number of digits to be shifted"
	return:			      [integer!]				"LTM-OKAY or an error code"
	/local
		new-slot	      [integer!]				;; used to shift digits
		old-slot	      [integer!]				;; used to shift digits
		response	      [integer!]				;;Response code from func calls
][
	;; if shift is 0 or less, there is nothing to do
	if shift < 1 [return LTM-OKAY]
	
	;; grow the size of the int if necessary
	if mp-int/used + shift > mp-int/alloc [
		response: LTM-grow mp-int mp-int/used + shift
		if response <> LTM-OKAY [return response]
	]
	
	;; copy the digits to their new position, starting with most significant
	;; and set the used to reflect the shift
	old-slot: mp-int/used
	mp-int/used: mp-int/used + shift
	new-slot: mp-int/used
	while [old-slot > 0][
		mp-int/mp-digit/new-slot: mp-int/mp-digit/old-slot
		new-slot: new-slot - 1
		old-slot: old-slot - 1
	]
	
	;; zero the lower digits
	LTM-zero-set(mp-int/mp-digit 1 shift)
	
	LTM-OKAY
]