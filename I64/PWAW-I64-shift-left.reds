Red/System [
	Purpose:	"Left shift 64-bit integer"
	Author:		"Peter W A Wood"
	Version:	0.1.0
	Rights:		"Copyright © 2014 Peter W A Wood. All rights reserved."
	License:	"Distributed under the Boost Software License, Version 1.0."
	"https://github.com/Red/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %PWAW-I64-int64-def.reds

PWAW-I64-shift-left: func [
	a				[PWAW-I64-int64!]
	b				[PWAW-I64-int64!]
	num-bits 		[integer!]
	return:			[integer!]
	/local		
		i			[integer!]
		carry 		[integer!]
][
	if num-bits > 63 [
		return PWAW-I64-EXCESSIVE-SHIFT
	]
	
	if num-bits = 0 [
		b/least-sig: a/least-sig
		b/most-sig: a/most-sig
		return PWAW-I64-OKAY
	]
	
	either num-bits > 31 [
		b/most-sig: a/least-sig << (num-bits - 32)
		b/least-sig:  0
	][
		i: 1
		carry: 0
		until [
			carry: carry << 1
			carry: carry + 1
			i: i + 1
			i > num-bits
		]
		carry: carry << (32 - num-bits)
		carry: a/least-sig and carry
		b/least-sig: a/least-sig << num-bits
		b/most-sig:	a/most-sig << num-bits
		if carry <> 0 [
			carry: carry >>> (32 - num-bits)
			b/most-sig: b/most-sig or carry 
		]
	]
	return PWAW-I64-OKAY
]



