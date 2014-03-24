Red/System [
  Purpose:	"Compares two mp-ints"
  Author:	"PeterWAWood"
  Version:	0.1.0
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-cmp: func [
	"Compares two mp-ints "
	a				    [LTM-int!]			  "The first integer"
	b				    [LTM-int!]			  "The second integer"	
	return:			[integer!]				"LTM-GT, LTM-EQ or LTM-LT"
		
][
	
	;; compare on basis of sign
	if a/sign <> b/sign [
		either a/sign = LTM-NEG [
			return LTM-LT
		][
			return LTM-GT
		]
	]
	
	;; compare absolute values 
	either a/sign = LTM-NEG [
		LTM-cmp-mag b a			;; if negative reverse comparison
	][
		LTM-cmp-mag a b
	]
	
]
