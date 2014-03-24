Red/System [
  Purpose:	"Copies an mp-int to another"
  Author:	"PeterWAWood"
  Version:	0.1.0
   License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-copy: func [
	"Copies an mp-int to another"
	a				    [LTM-int!]			  "The integer to be copied"
	b				    [LTM-int!]			  "The copy"	
	return:			[integer!]				"LTM-OKAY or an error code"
	/local
		i			    [integer!]
		response	[integer!]
	
][
	
	;; do nothing if a and b are the same
	if a = b [return LTM-OKAY]
	
	;; expand the destination if needed
	if a/used > b/alloc [
		response: LTM-grow b a/used
		if response <> LTM-OKAY [return response]
	]
	
	;; copy all the used digits from a to b
	if a/used > 0 [
		i: 1
		until [
			b/mp-digit/i: a/mp-digit/i
			i: i + 1
			i > a/used
		]
	]
		
	;; clear any remaining digits previously set in b
	if b/used > a/used [
		LTM-zero-set(b/mp-digit (a/used + 1) b/used)
	]
	
	;; copy used count and sign
	b/used: a/used
	b/sign: a/sign
	
	LTM-OKAY
	
]