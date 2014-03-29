Red/System [
	Purpose:	"Divides an integer by a power of 2"
	Author:		"PeterWAWood"
	Version:	0.1.0
	License:	{Distributed under the Boost Software License, Version 1.0.
				See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def
#include %LTM-clear.reds
#include %LTM-copy.reds
#include %LTM-mod-2d.reds
#include %LTM-rshd.reds
#include %LTM-zero.reds

LTM-div-2d: func [
	{ 
		shift right by a certain bit count:
		(storing quotient in c, remainder in d)
	}
	a					[LTM-int!]			"The integer to be dvided"
	b					[integer!]			"Shift count"
	c					[LTM-int!]			"Quotient"
	d					[LTM-int!]			"Remainder"
	return:				[integer!]			"LTM-OKAY or an error code"
	/local
		i				[integer!]			;; array index
		carry			[LTM-digit!]		;; carry digit
		mask			[LTM-digit!]
		next-carry		[LTM-digit!]		;; next carry digit to be applied
		num-bits		[integer!]			;; number of bits
		res				[integer!]			;; response code from library calls
		shift			[integer!]
][
	;; initialisation
	carry: LTM-DIGIT-ZERO
	mask: LTM-DIGIT-ZERO
	next-carry: LTM-DIGIT-ZERO
	shift: 0
	
	;; copy input to result for processing without affecting input
	res: LTM-copy a c
	if res <> LTM-OKAY [return res]
	
	;; if the shift count is 0 or less, return original value, 0 remainder
	if b < 1 [
		res: LTM-zero d
		if res <> 0 [return res]
	]
	
	;; get the remainder
	res: LTM-mod-2d a b d
	if res <> LTM-OKAY [
		LTM-clear d
		return res
	]
	
	;; shift by as many digits in the bit count
	if b >= LTM-DIGIT-BIT [
		LTM-rshd c (b / LTM-DIGIT-BIT)	
	]
	
	;; shift any bit count < digit bit
	num-bits: b % LTM-DIGIT-BIT
	if num-bits > 0 [
		mask:(LTM-DIGIT-ONE << num-bits) - 1
		shift: LTM-DIGIT-BIT - num-bits					;; for lsb
		i: c/used
		until [
			
			;; put the lower bits of this word into next-carry
			next-carry: c/mp-digit/i and mask
			
			;; shift current word and mix in any carry bits from previous word
			c/mp-digit/i: (c/mp-digit/i >> num-bits) or (carry << shift)
			
			carry: next-carry
			i: i - 1
			i < 1
		]
	]
	
	res: LTM-clamp c
	
	return res
]