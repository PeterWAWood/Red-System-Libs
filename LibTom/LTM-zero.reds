Red/System [
  Purpose:	"Sets a mp-int to zero"
  Author:	"PeterWAWood"
  Version:	0.1.0
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-zero: func [
	"Sets a mp-int to zero"
	mp-int				[LTM-int!]			"The integer to be zeroed"
	return:				[integer!]			"LTM-OKAY or an error code"
	/local
		i				[integer!]
][
	
	mp-int/sign: LTM-ZPOS
	mp-int/used: 0
	
	i: 1
	until [
		mp-int/mp-digit/i: LTM-ZERO-DIGIT
		i: i + 1
		i > mp-int/alloc
	]
	
	LTM-OKAY
	
]