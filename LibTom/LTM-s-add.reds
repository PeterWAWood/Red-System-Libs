Red/System [
  Purpose:	"low level addition - absolute values"
  Author:	"PeterWAWood"
  Version:	0.1.0
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-s-add: func [
	"low level addition - absolute values"
	a				                    [LTM-int!]				"The first integer of the addition"
	b				                    [LTM-int!]				"The second"
	c				                    [LTM-int!]				"The responseult of the addition"
	return:			                [integer!]				"LTM-OKAY or an error code"
	/local
		carry		                  [LTM-digit!]			;; carry digit
		i			                    [integer!]				;; counter
		min			                  [integer!]				;; min number of digits
		max			                  [integer!]				;; max number of digits
		oldused		                [integer!]				;; value of c/used at start
		response	                [integer!]				;; call responseponse code
		x			                    [LTM-int!]				;; used to point to larger of the 2 mp-int!
][
	
	;; find sizes and point x at the larger of the inputs
	either a/used > b/used [
		min: b/used
		max: a/used
		x: a
	][
		min: a/used
		max: b/used
		x: b
	]
	
	;; extend the responseult if needed
	if c/alloc < (max + 1) [
		response: LTM-grow c (max + 1)
		if response <> LTM-OKAY [return response]
	]
	
	;; get old used digit count and set new one
	oldused: c/used
	c/used: max + 1
	
	;; zero the carry
	carry: as LTM-digit! 0
	
	;; perform the addition
	
	;;add the digits which both numbers have
	;; compute sum one digit at a time
	i: 1
	until [						
		;; Sum[i] = A[i] + B[i] + Carry
		c/mp-digit/i: a/mp-digit/i + b/mp-digit/i + carry
		
		;; carry = carry bit of Sum[i]
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
			;; add each digit with the carry
			c/mp-digit/i: x/mp-digit/i + carry

			;; get carry for next digit
			carry: c/mp-digit/i >>> LTM-DIGIT-BIT

			;; take away carry from Sum[i]
			c/mp-digit/i: c/mp-digit/i and LTM-MASK
			
			i: i + 1
			
			i > max
		]
	]
	
	;; add in the last carry
	;;  no need to check for non-zero as any leanding zeroes will be removed by 
	;;  calling clamp
	i: max + 1
	c/mp-digit/i: carry

	;; clear any digits in responseult that may have been left over
	if oldused > max [ LTM-zero-set(b/mp-digit (max + 1) oldused)]
	
	;; remove any leading zeros
	;; clamp will return okay or an error
	LTM-clamp c
	
]
