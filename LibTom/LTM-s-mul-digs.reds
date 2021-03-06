Red/System [
  Purpose:	{multiples absolute values of two integers
	           only computes up to the number of digits supplied in args }
  Author:	"PeterWAWood"
  Version:	0.1.0
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-s-mul-digs: func [
	{multiples absolute values of two integers
	  only computes up to the number of digits supplied in args }
	a					[LTM-int!]			"First integer"
	b					[LTM-int!]			"Second integer"
	c					[LTM-int!]			"The result"
	digits				[integer!]			" Number of digits to be computed"
	return:				[integer!]			"LTM-OKAY or an error code"
	/local
		carry			[LTM-digit!]		;; carry digit
		ia				[integer!]			;; counter
		ib				[integer!]			;; counter
		min				[integer!]			;; min number of digits
		max				[integer!]			;; max number of digits
		oldused			[integer!]			;; value of c/used at start
		response		[integer!]			;; call response code
		t				[LTM-int!]			;; t
][

	;; can the fast multiplier be used
	;; code to be added later
	
	
	;; allocate a temporary MP-int of the size requested
	response: LTM-init-size t digits
	if response <> LTM-OKAY [
		return response
	]
	t/used: digits
	
	;; compute the digits of the product directly
	ix: 1
	until [
		
		
		ix: ix + 1
		ix < a/used		
	]
	
	
	LTM-OKAY	
]
