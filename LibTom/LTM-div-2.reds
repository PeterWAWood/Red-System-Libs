Red/System [
  Purpose:	"Divides an integer by 2"
  Author:	"PeterWAWood"
  Version:	0.1.0
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-div-2: func [
	"Divides an integer by 2"
	a				      [LTM-int!]				"The integer to be halved"
	b				      [LTM-int!]				"Half the integer"
	return:			  [integer!]				"LTM-OKAY or an error code"
	/local
		i			      [integer!]				;; array index
		carry		    [LTM-digit!]			;; carry digit
		next-carry	[LTM-digit!]			;; next carry digit to be applied
		oldused		  [integer!]				;; to store b/used as input
		response	  [integer!]				;; response code from library calls			
][

	;; make sure there are sufficient digits to store the result
	if b/alloc < a/used [
		response: LTM-grow b a/used
		if response <> LTM-OKAY [return response]
	]
	
	;; set used value of result
	oldused: b/used
	b/used: a/used
	
	;; divide by two, one digit at time
	carry: LTM-ZERO-DIGIT
	i: b/used
		
	until [
		
		;;get what will be the next carry digit from 
		;; the most significant bit of the current digit
		next-carry: a/mp-digit/i and as LTM-digit! 1
		
		;; now shift up this digit and add in previous carry
		b/mp-digit/i: (a/mp-digit/i >>> 1) or (carry << (LTM-DIGIT-BIT - 1))
		
		;;set the carry
		carry: next-carry
		
		i: i - 1
		i < 1
	]
		
	;; zero any excess digits that may not have been written over in the result
	if b/used < oldused [
		LTM-zero-set (b/mp-digit (b/used + 1) oldused)
	]
	
	;; finally set the sign
	b/sign: a/sign
	
	LTM-clamp b 						;; LTM-clamp retuns LTM-OKAY

]