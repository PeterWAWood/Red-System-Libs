Red/System [
	Purpose:	"Divides the absolute value of a 64-bit integer by another"
	Author:		"Peter W A Wood"
	Version:	0.1.0
	Rights:		"Copyright © 2014 Peter W A Wood. All rights reserved."
	License:	"Distributed under the Boost Software License, Version 1.0."
	"https://github.com/Red/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %PWAW-I64-int64-def.reds
#include %PWAW-I64-abs-add.reds
#include %PWAW-I64-abs-sub.reds
#include %PWAW-i64-greater.reds
#include %PWAW-I64-shift-left.reds
#include %PWAW-I64-shift-right.reds

PWAW-I64-abs-div: func [
	a					[PWAW-I64-int64!]
	b					[PWAW-I64-int64!]
	c					[PWAW-I64-int64!]
	d					[PWAW-I64-int64!]
	return:				[integer!]
	/local
		product			[PWAW-I64-int64!]
		quotient		[PWAW-I64-int64!]
		remainder		[PWAW-I64-int64!]
		resp			[integer!]
		term			[PWAW-I64-int64!]
][
	if PWAW-I64-zero?(b) [
		return PWAW-I64-ZERO-DIVIDE
	]
	
	PWAW-I64-zero-int64(c)
	PWAW-I64-zero-int64(d)
	
	if PWAW-I64-greater? b a [
		PWAW-I64-copy(a d)
		return PWAW-I64-OKAY
	]
	
	if PWAW-I64-equal?(a b) [
		PWAW-I64-copy(PWAW-I64-one c)
		return PWAW-I64-OKAY
	]
	
	if PWAW-I64-equal?(b PWAW-I64-one) [
		PWAW-I64-zero-int64(d)
		PWAW-I64-copy(a c)
		return PWAW-I64-OKAY
	]

	;; algorithm from:
	;; http://www.dragonwins.com/domains/getteched/de248/binary_division.htm
	

	product: declare PWAW-I64-int64!
	quotient: declare PWAW-I64-int64!
	remainder: declare PWAW-I64-int64!
	term: declare PWAW-I64-int64!

	PWAW-I64-copy(a remainder)
	PWAW-I64-copy(b product)
	PWAW-I64-copy(PWAW-I64-one term)
	PWAW-I64-zero-int64(quotient)
	
	if any [
			remainder/most-sig > 0FFFFFFFh
	][
		until [
			resp: PWAW-I64-shift-left term term 1
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
			resp: PWAW-I64-shift-left product product 1
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
			any [
				term/most-sig > 0
				PWAW-I64-greater? product remainder
			]
		]
		
		if term/most-sig > 0 [
			resp: PWAW-I64-shift-right term term 1
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
			resp: PWAW-I64-shift-right product product 1
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)	
		]
		
		while [PWAW-I64-greater? product remainder] [
			resp: PWAW-I64-shift-right term term 1
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
			resp: PWAW-I64-shift-right product product 1
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
		]
		
		resp: PWAW-I64-abs-sub remainder product remainder
		PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
		resp: PWAW-I64-abs-add quotient term quotient
		PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
	]
	
	PWAW-I64-copy(PWAW-I64-one term)
	PWAW-I64-copy(b product)
	
	while [
		all [
			(term/most-sig and E0000000h) <> E0000000h
			PWAW-I64-greater? remainder product
		]
	][
			resp: PWAW-I64-shift-left term term 1
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
			resp: PWAW-I64-shift-left product product 1
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
	]
	
	while [
		all [
			0 = (term/least-sig and 1)
			not PWAW-I64-zero?(remainder)
		]
	] [
		if not PWAW-I64-greater? product remainder [
			resp: PWAW-I64-abs-add quotient term quotient
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
			resp: PWAW-I64-abs-sub remainder product remainder
			PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
		]
		resp: PWAW-I64-shift-right product product 1
		PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
		resp: PWAW-I64-shift-right term term 1
		PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
	]
	
	either PWAW-I64-equal?(product remainder) [
		resp: PWAW-I64-abs-add quotient PWAW-I64-one c
		PWAW-I64-return-if(resp <> PWAW-I64-OKAY)
	][
		PWAW-I64-copy(quotient c)
		PWAW-i64-copy(remainder d)
	]
	PWAW-I64-OKAY			
]

