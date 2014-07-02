Red/System [
	Purpose:	"Subtracts one 64-bit integer from another"
	Author:		"Peter W A Wood"
	Version:	0.1.0
	Rights:		"Copyright © 2014 Peter W A Wood. All rights reserved."
	License:	"Distributed under the Boost Software License, Version 1.0."
	"https://github.com/Red/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %PWAW-I64-int64-def.reds
#include %PWAW-I64-abs-add.reds
#include %PWAW-I64-abs-sub.reds
#include %PWAW-I64-greater.reds
#include %PWAW-I64-negate.reds

PWAW-I64-sub: func [
	a				[PWAW-I64-int64!]
	b				[PWAW-I64-int64!]
	c				[PWAW-I64-int64!]
	return:			[integer!]
	/local
		resp		[integer!]
		temp		[PWAW-I64-int64!]
		temp2		[PWAW-I64-int64!]
		temp3		[PWAW-I64-int64!]
][
	temp: declare PWAW-I64-int64!
	temp2: declare PWAW-I64-int64!
	temp3: declare PWAW-I64-int64!
	PWAW-I64-zero-int64(temp)
	PWAW-I64-zero-int64(temp2)
	PWAW-I64-zero-int64(temp3)
	
	either PWAW-I64-positive?(a) [
		either PWAW-I64-positive? (b) [
			either PWAW-I64-greater? a b [
				return PWAW-I64-abs-sub a b c
			][
				resp: PWAW-I64-abs-sub b a temp
				PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
				return PWAW-I64-negate temp c
			]
		][
			;a +ve, b-ve
			resp: PWAW-I64-negate b temp
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
			return PWAW-I64-abs-add a temp c
		]
	][
		; a -ve
		either PWAW-I64-positive? (b) [
			resp: PWAW-I64-negate a temp
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
			resp: PWAW-I64-abs-add temp b temp2
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
			return PWAW-I64-negate temp3 c
		][
			; a-ve, b-ve
			resp: PWAW-I64-negate a temp
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
			resp: PWAW-I64-negate b temp2
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
			either PWAW-I64-greater? temp temp2 [
				resp: PWAW-I64-abs-sub temp temp2 temp3
			][
				resp: PWAW-I64-abs-sub temp2 temp temp3
			]
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
			return PWAW-I64-negate temp3 c
		]		
	]
]



