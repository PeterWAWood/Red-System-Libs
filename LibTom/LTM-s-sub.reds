Red/System [
  Purpose:	"low level subtraction - absolute values - first number must be larger of two"
  Author:	"PeterWAWood"
  Version:	0.1.0
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-s-sub: func [
	"low level subtraction - absolute values - first number must be larger of two"
	a		                			[LTM-int!]			"The larger integer"
	b					                [LTM-int!]			"The integer to be subtracted"
	c					                [LTM-int!]			"The result"
	return:				            [integer!]			"LTM-OKAY or an error code"
	/local
		carry			              [LTM-digit!]		;; carry digit
		i				                [integer!]			;; counter
		min				              [integer!]			;; min number of digits
		max				              [integer!]			;; max number of digits
		oldused			            [integer!]			;; value of c/used at start
		response		            [integer!]			;; call response code
][
	
	;; find sizes
	min: b/used
	max: a/used
	
	;; extend the responseult if needed
	if c/alloc < max [
		response: LTM-grow c max
		if response <> LTM-OKAY [return response]
	]
	
	;; get old used digit count and set new one
	oldused: c/used
	c/used: max
	
	;; zero the carry
	carry: as LTM-digit! 0
	
	;; perform the subtraction
	
	;;subtract the digits which both numbers have
	;; compute answers one digit at a time
	i: 1
	until[						
		;; C[i] = A[i] - B[i] - Carry
		c/mp-digit/i: a/mp-digit/i - b/mp-digit/i - carry
		
		;; carry = carry bit of C[i]
		carry: c/mp-digit/i >>> LTM-DIGIT-BIT
		
		;; take away carry bit from Sum[i]
		c/mp-digit/i: c/mp-digit/i and LTM-MASK

		;; increment counter and pointers
		i: i + 1
		
		i > min
	]

	;; now copy the "higher" digits, remembering to carry where needed

	if max > min [
		i: min + 1
		until [
			;; copy each digit but remembering the carry
			c/mp-digit/i: a/mp-digit/i - carry

			;; get carry for next digit
			carry: c/mp-digit/i >>> LTM-DIGIT-BIT

			;; take away carry from C[i]
			c/mp-digit/i: c/mp-digit/i and LTM-MASK
			
			i: i + 1
			
			i > max
		]
	]
	
	;; clear any digits in result that may have been left over
	if oldused > max [ LTM-zero-set(c/mp-digit (max + 1) oldused)]
	
	;; remove any leading zeros
	;; clamp will return okay or an error
	LTM-clamp c
	
]