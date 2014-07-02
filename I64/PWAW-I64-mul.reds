Red/System [
	Purpose:	"Multipleis two 64-bit integers"
	Author:		"Peter W A Wood"
	Version:	0.1.0
	Rights:		"Copyright © 2014 Peter W A Wood. All rights reserved."
	License:	"Distributed under the Boost Software License, Version 1.0."
	"https://github.com/Red/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %PWAW-I64-int64-def.reds
#include %PWAW-I64-abs-mul.reds
#include %PWAW-I64-greater.reds
#include %PWAW-I64-negate.reds

PWAW-I64-mul: func [
	a				[PWAW-I64-int64!]
	b				[PWAW-I64-int64!]
	c				[PWAW-I64-int64!]
	return:			[integer!]
	/local
		negate-ans?	[logic!]
		resp		[integer!]
		temp-a		[PWAW-I64-int64!]
		temp-b		[PWAW-I64-int64!]
		temp-c		[PWAW-I64-int64!]
][
	temp-a: declare PWAW-I64-int64!
	temp-b: declare PWAW-I64-int64!
	temp-c: declare PWAW-I64-int64!
	
	either PWAW-I64-positive?(a) [
		either PWAW-I64-positive? (b) [
			PWAW-I64-copy(a temp-a)
			PWAW-I64-copy(b temp-b)
			negate-ans?: false
		][
			;a +ve, b-ve
			PWAW-I64-copy(a temp-a)
			resp: PWAW-I64-negate b temp-b
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
			negate-ans?: true
		]
	][
		; a -ve
		either PWAW-I64-negative? (b) [
			resp: PWAW-I64-negate a temp-a
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
			resp: PWAW-I64-negate b temp-b
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
			negate-ans?: false
		][
			; a-ve, b+ve
			resp: PWAW-I64-negate a temp-a
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
			PWAW-I64-copy(b temp-b)
			negate-ans?: true
		]		
	]
	
	resp: PWAW-I64-abs-mul temp-a temp-b temp-c
	PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
	either negate-ans? [
		resp: PWAW-I64-negate temp-c c
		PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
	][
		PWAW-I64-copy(temp-c c)
	]
	PWAW-I64-OKAY
]



