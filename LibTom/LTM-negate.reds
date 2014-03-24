Red/System [
  Purpose:	"Negates an mp-int"
  Author:	"PeterWAWood"
  Version:	0.1.0
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-negate: func [ "Negates an mp-int"
	a             				    [LTM-int!]				"The original integer"
	b				                  [LTM-int!]				"The negated integer"
	return:			              [integer!]				"LTM-OKAY or an error code"
	/local
		response	              [integer!]
][
	
	;; copy a to b
	if a <> b [
		response: LTM-copy a b
		if response <> LTM-OKAY [return response]
	]

	;; force sign of zero values to positive, otherwise swap the sign
	either LTM-zero?(b) [
		b/sign: LTM-ZPOS
	][
		either a/sign = LTM-ZPOS [b/sign: LTM-NEG] [b/sign: LTM-ZPOS]	
	]
	
	LTM-OKAY
]