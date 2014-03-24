Red/System [
  Purpose:	"Shift right a number of digits"
  Author:	"PeterWAWood"
  Version:	0.1.0
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-rshd: func [
	"Shift right a number of digits"
	mp-int			              [LTM-int!]				"The integer to be right shifted"
	shift		                	[integer!]				"Number of digits to be shifted"
	return:			              [integer!]				"LTM-OKAY or an error code"
	/local
		new-slot	              [integer!]				;; used to shift digits
		old-slot	              [integer!]				;; used to shift digits
		old-used	              [integer!]				;; store original used value
][
	;; if shift is 0 or less, there is nothing to do
	if shift < 1 [return LTM-OKAY]
	
	
	;; copy the digits to their new position, starting with least significant
	;; and set the used to reflect the shift
	old-used: mp-int/used
	old-slot: shift + 1
	mp-int/used: mp-int/used - shift
	new-slot: 1
	until [
		mp-int/mp-digit/new-slot: mp-int/mp-digit/old-slot
		new-slot: new-slot + 1
		old-slot: old-slot + 1
		new-slot > mp-int/used
	]
	
	;; zero the upper digits
	LTM-zero-set(mp-int/mp-digit (mp-int/used + 1) old-used)
	
	LTM-OKAY
]