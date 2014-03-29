Red/System [
	Purpose:	"Gives the remainder when dividing an integer by a power of 2"
	Author:		"PeterWAWood"
	Version:	0.1.0
	License:	{Distributed under the Boost Software License, Version 1.0.
				See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def
#include %LTM-clear.reds
#include %LTM-copy.reds
#include %LTM-zero.reds

LTM-mod-2d: func [
	{ calculate a mod 2**b}
	a					[LTM-int!]			"The integer to be dvided"
	b					[integer!]			"Shift count"
	c					[LTM-int!]			"Remainder"
	return:				[integer!]			"LTM-OKAY or an error code"
	/local
		i				[integer!]			;; array index
		mask			[LTM-digit!]		;; bit mask 
		res				[integer!]			;; response code from library calls
][
		
	;; if the shift count is 0 or less, set remainder to zero
	if b < 1 [
		res: LTM-zero c
		return res
	]
	
	;; copy the value
	res: LTM-copy a c
	if res <> LTM-OKAY [return res]
	
	;;if the modulus is larger than the value, return the value
	if b >= (a/used * LTM-DIGIT-BIT) [return LTM-OKAY]
	
	;; zero the digits above the last digit of the modulus
	i: (b / LTM-DIGIT-BIT) + 1
	if b % LTM-DIGIT-BIT > 0 [i: i + 1]

	until [
		c/mp-digit/i: LTM-ZERO-DIGIT
		i: i + 1
		i > c/used
	]
	
	;; clear the digit where the remainder digits start
	i: (b / LTM-DIGIT-BIT) + 1
	mask: (LTM-ONE-DIGIT << (as LTM-digit! b)) - LTM-ONE-DIGIT
	c/mp-digit/i: c/mp-digit/i and mask
	
	res: LTM-clamp c
	
	return res
]