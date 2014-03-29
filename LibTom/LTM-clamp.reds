Red/System [
	Purpose:	"Trims unused digits from an integer"
	Author:		"Peter W A Wood"
	Version:	0.1.0
	License:	{Distributed under the Boost Software License, Version 1.0.}
]

#include %libtommaths.def

LTM-clamp: func [
	"Trims unused digits from an mp-int!"
	mp-int			[LTM-int!]			"The integer to be trimmed"
	return:			[integer!]			"LTM-OKAY or an error code"
	/local
		i			[integer!]	
][

	;; decrease used whilst the most significant digit is zero 
	i: mp-int/used
	while [
		all [
			LTM-ZERO-DIGIT = mp-int/mp-digit/i
			mp-int/used <> 0
		]
	][
		mp-int/used: mp-int/used - 1
		i: i - 1 
	]

	;; make sure sign is positive if size is zero
	if mp-int/used = 0 [mp-int/sign: LTM-ZPOS]
	
	LTM-OKAY
	
]