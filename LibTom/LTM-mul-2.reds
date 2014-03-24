Red/System [
  Purpose:	"Multiples an integer by 2"
  Author:	"PeterWAWood"
  Version:	0.1.0
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-mul-2: func [ "Multiples an integer by 2"
	a				            [LTM-int!]				"The integer to be doubled"
	b				            [LTM-int!]				"Double the integer"
	return:			        [integer!]				"LTM-OKAY or an error code"
	/local
		i			            [integer!]				;; array index
		carry		          [LTM-digit!]			;; carry digit
		next-carry	      [LTM-digit!]			;; next carry digit to be applied
		oldused		        [integer!]				;; to store b/used as input
		response	        [integer!]				;; response code from library calls
][

	;; make sure there are sufficient digits to store the response
	if b/alloc < (a/used + 1) [
		response: LTM-grow b (a/used + 1)
		if response <> LTM-OKAY [return response]
	]
	
	;; set used value of response
	oldused: b/used
	b/used: a/used
	
	;; multliply by two, one digit at time
	carry: LTM-ZERO-DIGIT
	i: 1
	
	until [
		
		;;get what will be the next carry digit from 
		;; the most significant bit of the current digit
		next-carry: a/mp-digit/i >>> (LTM-DIGIT-BIT - 1)
		
		;; now shift up this digit and add in previous carry
		b/mp-digit/i: ((a/mp-digit/i << 1) or carry) and LTM-MASK
		
		;;set the carry
		carry: next-carry
		
		i: i + 1
		i > a/used
	]
	
	;; add a new leading digit if there is a carry from the final shift
	;;  it will always be 1
	;; note: i has already been incremented to be a/used + 1
	if carry <> LTM-ZERO-DIGIT [
		b/mp-digit/i: as LTM-digit! 1
		b/used: b/used + 1
	]
	
	;; zero any excess digits that may not have been written over in the response
	if b/used < oldused [
		LTM-zero-set (b/mp-digit (b/used + 1) oldused)
	]
	
	;; finally set the sign
	b/sign: a/sign
	
	LTM-OKAY

]