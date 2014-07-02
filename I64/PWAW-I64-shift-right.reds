Red/System [
	Purpose:	"Right shift 64-bit integer"
	Author:		"Peter W A Wood"
	Version:	0.1.0
	Rights:		"Copyright © 2014 Peter W A Wood. All rights reserved."
	License:	"Distributed under the Boost Software License, Version 1.0."
	"https://github.com/Red/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %PWAW-I64-int64-def.reds

PWAW-I64-shift-right: func [
	a				[PWAW-I64-int64!]
	b				[PWAW-I64-int64!]
	num-bits 		[integer!]
	return:			[integer!]
	/local		
		i			[integer!]
		il			[integer!]	
		carry 		[integer!]
][
	if num-bits > 63 [
		return PWAW-I64-EXCESSIVE-SHIFT
	]
	
	if num-bits = 0 [
		PWAW-I64-copy(a b)
		return PWAW-I64-OKAY
	]
	
	either num-bits > 31 [
		b/least-sig: a/most-sig >>> (num-bits - 32)
		b/most-sig: 0
	][
		il: a/least-sig >>> num-bits
		i: 1
		carry: 0
		until [ 
			carry: carry << 1
			carry: carry + 1
			i: i + 1
			i > num-bits
		]
		carry: a/most-sig and carry
		if  carry <> 0 [
			carry: carry << (32 - num-bits)
			il: il or carry
		]
	
		b/most-sig:	a/most-sig >>> num-bits
		b/least-sig: il
	]
	return PWAW-I64-OKAY
]



