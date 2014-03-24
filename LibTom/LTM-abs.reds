Red/System [
  Purpose:	"Provides the absolute value of a mp-int"
  Author:	"PeterWAWood"
  Version:	0.1.0
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-abs: func [
	"Provides the absolute value of a mp-int"
	a				[LTM-int!]	"The original integer"
	b				[LTM-int!]	"The absolute value"
	return:			[integer!]		"LTM-OKAY or an error code"
	/local
		response	[integer!]
][
	;; copy a to b
	if a <> b [
		response: LTM-copy a b
		if response <> LTM-OKAY [return response]
	]
	
	;; force sign of b to positive
	b/sign: LTM-ZPOS
	
	LTM-OKAY
	
]
