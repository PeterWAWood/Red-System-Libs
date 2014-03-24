Red/System [
  Purpose:	"high level subtraction"
  Author:	"PeterWAWood"
  Version:	0.1.0
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-sub: func [
	"high level subtraction"
	a					                [LTM-int!]			"The initial integer"
	b					                [LTM-int!]			"The integer to be subtracted"
	c					                [LTM-int!]			"The result of the subtraction"
	return:				            [integer!]			"LTM-OKAY or an error code"
	/local
		response		            [integer!]			;; call responseponse code
		size-a			            [integer!]			;; size of first integer
		size-b			            [integer!]			;; size of second integer
][
	
	;; get sign of both inputs
	sign-a: a/sign
	sign-b: b/sign
	
	either sign-a <> sign-b [				
		;; subtract a negative from a positive or +ve from a -ve
		;; in either case, add their magnitudes and use sign from 1st number
		c/sign: sign-a
		response: LTM-s-add a b c				
	][
		;; subtract a positive from a positive or -ve from -ve
		;; take the difference between their magnitudes
		;; subtract the smaller from the larger
		;; adjusting the sign as necessary
		either LTM-LT <> LTM-cmp-mag a b [
			;; first number is larger or they are equal in magnitude
			
			;; take sign from first one and subtract second from first
			c/sign: sign-a
			response: LTM-s-sub a b c
		][
			;; the second is of greater magnitude
			;; the responseult will have the opposite sign to the first number
			either sign-a = LTM-ZPOS [
				c/sign: LTM-NEG
			][
				c/sign: LTM-ZPOS
			]
			response: LTM-s-sub b a c
		]
	]

	response
	
]
