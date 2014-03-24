Red/System [
  Purpose:	"Sets a mp-int from a 32-bit integer"
  Author:	"PeterWAWood"
  Version:	0.1.0
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-set-int: func [
	"Sets a mp-int to a 32-bit integer"
	mp-int				                [LTM-int!]			"The mp integer to be set"
	int					                  [integer!]			"The integer"
	return:				                [integer!]			"LTM-OKAY or an error code"
	/local
		i				                    [integer!]			;; loop counter
		j				                    [integer!]			;; temp
		k				                    [integer!]			;; temp
		response		                [integer!]			;; response from lib calls
][
	
	LTM-zero mp-int
	
	;; set the mp-int four bits at a time ie 8 iterations
	i: 1
	until [
		
		;; shift the number four bits to the left
		response: LTM-mul-2d mp-int 4 mp-int

		if response <> LTM-OKAY [return response]
		
		;; OR in the top four bits of the source
		k: int >>> 28					;; These two statements are required
		j: 15 and k						;;  due to unexpected result if they 
										;;  are removed.
		mp-int/mp-digit/value: mp-int/mp-digit/value or (as LTM-digit! j)
							   
		;; shift the next four bits to the front of the integer
		int: int << 4
		
		;; increase used count on each iteration to be absolutely certain 
		;; nothing gets throw away by clamp (which is called in mul-2d)
		mp-int/used: mp-int/used + 1
		
		i: i + 1
		i > 8
	]
	
	;; remove leading zeros from the mp-int
	LTM-clamp mp-int 						;; returns LTM-OKAY 
	
]