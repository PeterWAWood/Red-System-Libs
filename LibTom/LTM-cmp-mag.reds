Red/System [
  Purpose:	"Compares the magnitude of two mp-ints (unsigned)"
  Author:	"PeterWAWood"
  Version:	0.1.0
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

#include %LTM-abs.reds
#include %LTM-add.reds
#include %LTM-clamp.reds
#include %LTM-clear.reds
#include %LTM-cmp.reds

LTM-cmp-mag: func [
	"Compares the magnitude of two mp-ints (unsigned)"
	a				    [LTM-int!]				"The first integer"
	b				    [LTM-int!]				"The second integer"	
	return:			[integer!]				"LTM-GT, LTM-EQ or LTM-LT"
	/local
		i			    [integer!]			
		
][
	
	;; compare on basis of non-zero digits
	if a/used > b/used [return LTM-GT]
	if a/used < b/used [return LTM-LT]
	if a/used = 0 [return LTM-EQ]         	;; both are zero
	
	;;compare from most significant digit
	i: a/used
	until [
		if a/mp-digit/i > b/mp-digit/i [return LTM-GT]
		if a/mp-digit/i < b/mp-digit/i [return LTM-LT]
				
		i: i - 1
		i < 1
	]

	LTM-EQ
	
]