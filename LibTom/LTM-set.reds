Red/System [
  Purpose:	"Sets a mp-int to a digit"
  Author:	"PeterWAWood"
  Version:	0.1.0
  File:		%libtommaths.reds		 
  Descripton:	"A reduced implementation of LibTomMath authored by Tom St Denis"
  License:	{Distributed under the Boost Software License, Version 1.0.
			See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt}
]

#include %libtommaths.def

LTM-set: func [
	"Sets a mp-int to a digit"
	mp-int			                  [LTM-int!]				"The integer to be set"
	mp-digit		                  [LTM-digit!]			"The digit"
	return:			                  [integer!]				"LTM-OKAY or an error code"
	/local
		response	                  [integer!]
][
	;; check number can be stored in a single digit
	if mp-digit > LTM-MASK [return LTM-TOO-BIG]
	
	;; set to zero
	response: LTM-zero mp-int
	if response <> LTM-OKAY [return response]
	
	; set first digit
	mp-int/mp-digit/value: mp-digit and LTM-MASK
	either mp-int/mp-digit/value = LTM-ZERO-DIGIT [
		mp-int/used: 0
	][
		mp-int/used: 1
	]
	
	LTM-OKAY
	
]