Red/System [
  Purpose:	"High level addition"
  Author:	"PeterWAWood"
  Version:	0.1.0
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-add: func [
	"high level addition"
	a				[LTM-int!]			"The first integer of the addition"
	b				[LTM-int!]			"The second"
	c				[LTM-int!]			"The result of the addition"
	return:			[integer!]			"LTM-OKAY or an error code"
	/local
		response	[integer!]			;; call response code
		size-a		[integer!]			;; size of first integer
		size-b		[integer!]			;; size of second integer
][
	
	;; get sign of both inputs
	sign-a: a/sign
	sign-b: b/sign
	
	either sign-a = sign-b [				
		;; add the two numbers if they have the same sign
		c/sign: sign-a
		response: LTM-s-add a b c				
	][
		;; subtract the one with lesser magnitude from the other
		;; take the sign of the larger
		;; note: if the result of the addition is zero, LTM-clamp which is
		;;       called by both LTM-s-add and LTM-s-sub will ensure the sign
		;;		 is set correctly	
		either LTM-LT = LTM-cmp-mag a b  [
			c/sign: sign-b
			response: LTM-s-sub b a c
		][
			c/sign: sign-a
			response: LTM-s-sub a b c
		]	
	]
	
	response
	
]