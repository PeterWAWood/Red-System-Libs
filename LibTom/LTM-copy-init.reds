Red/System [
  Purpose:	"Clones a multiple-precision integer"
  Author:	"PeterWAWood"
  Version:	0.1.0
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

#include %LTM-copy.reds


LTM-copy-init: func [
	"Clones an mp-int, ie initialises an mp-int then copies the original"
	a				[LTM-int!]				"The cloan"
	b				[LTM-int!]				"The integer to be copied"	
	return:			[integer!]				"LTM-OKAY or an error code"
	/local
		response	[integer!]
	
][
	
	;; initialise the clone
	response: LTM-init a
	if response <> LTM-OKAY [return response]
	
	;; copy the orignal into the clone
	LTM-copy b a
	
]