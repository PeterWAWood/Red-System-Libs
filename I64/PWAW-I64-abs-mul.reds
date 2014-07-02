Red/System [
	Purpose:	"Multiplies the absolute values of two 64-bit integers"
	Author:		"Peter W A Wood"
	Version:	0.1.0
	Rights:		"Copyright © 2014 Peter W A Wood. All rights reserved."
	License:	"Distributed under the Boost Software License, Version 1.0."
	"https://github.com/Red/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %PWAW-I64-int64-def.reds
#include %PWAW-I64-abs-add.reds
#include %PWAW-I64-shift-left.reds

PWAW-I64-abs-mul: func [
	a				[PWAW-I64-int64!]
	b				[PWAW-I64-int64!]
	c				[PWAW-I64-int64!]
	return:			[integer!]
	/local
		i				[integer!]
		resp		[integer!]
		temp1		[PWAW-I64-int64!]
		temp2		[PWAW-I64-int64!]
		temp3		[PWAW-I64-int64!]
][
	temp1: declare PWAW-I64-int64!
	temp2: declare PWAW-I64-int64!
	temp3: declare PWAW-I64-int64!
	
	PWAW-I64-zero-int64(c)
	
	if any [
		PWAW-I64-zero?(a)
		PWAW-I64-zero?(b)
	][
		return PWAW-I64-OKAY
	]
	
	PWAW-I64-copy(b temp1)
	i: 1
	until [
		resp: PWAW-I64-shift-left c temp2 1
		PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
		either 40000000h = (temp1/most-sig and 40000000h) [
			resp: PWAW-I64-abs-add a temp2 c
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
		][
			PWAW-I64-copy(temp2 c)	
		]
		resp: PWAW-I64-shift-left temp1 temp3 1
		PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
		PWAW-I64-copy(temp3 temp1)
		i: i + 1
		i > 63
	]
	
	PWAW-I64-OKAY
	
]



