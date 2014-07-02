Red/System [
	Purpose:	"Subtract the values of two positive 64-bit integers"
	Author:		"Peter W A Wood"
	Version:	0.1.0
	Rights:		"Copyright © 2014 Peter W A Wood. All rights reserved."
	License:	"Distributed under the Boost Software License, Version 1.0."
	"https://github.com/Red/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %PWAW-I64-int64-def.reds
#include %PWAW-I64-greater.reds

PWAW-I64-abs-sub: func [
	"Subtract a positive integer from a larger one"
	a				[PWAW-I64-int64!]
	b				[PWAW-I64-int64!]
	c				[PWAW-I64-int64!]
	return:			[integer!]
	/local
		a-least		[integer!]
][

	if any [
		a/most-sig < 0
		b/most-sig < 0
		PWAW-I64-greater? b a
	][
		return PWAW-I64-INVALID-ARG
	]
	
	if PWAW-I64-equal?(a b) [
		PWAW-I64-zero-int64(c)
		return PWAW-I64-OKAY
	]
	
	a-least: a/least-sig
	c/most-sig: a/most-sig - b/most-sig
	c/least-sig: as integer! (as pointer! [integer!] a/least-sig) - 
							 (as pointer! [integer!] b/least-sig)
	if any [
		(as pointer! [integer!] a-least) < 
		(as pointer! [integer!] c/least-sig)
	][
		c/most-sig: c/most-sig - 1
	]
		
	PWAW-I64-OKAY
]



