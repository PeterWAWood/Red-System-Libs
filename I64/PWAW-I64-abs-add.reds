Red/System [
	Purpose:	"Sum of the absolute values of two 64-bit integers"
	Author:		"Peter W A Wood"
	Version:	0.1.0
	Rights:		"Copyright © 2014 Peter W A Wood. All rights reserved."
	License:	"Distributed under the Boost Software License, Version 1.0."
	"https://github.com/Red/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %PWAW-I64-int64-def.reds
#include %PWAW-I64-greater.reds

PWAW-I64-abs-add: func [
	a				[PWAW-I64-int64!]
	b				[PWAW-I64-int64!]
	c				[PWAW-I64-int64!]
	return:			[integer!]
	/local
		carry		[integer!]
][

	c/least-sig: a/least-sig + b/least-sig
	either any [
			(as int-ptr! a/least-sig) > (as int-ptr! c/least-sig)
			(as int-ptr! b/least-sig) > (as int-ptr! c/least-sig)
	][
		carry: 1
	][
		carry: 0
	]
	c/most-sig: a/most-sig + b/most-sig + carry
	either any [
		PWAW-I64-greater? a c
		PWAW-I64-greater? b c 
	][
		PWAW-I64-OVERFLOW
	][
		PWAW-I64-OKAY
	]
]



