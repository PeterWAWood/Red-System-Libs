Red/System [
	Purpose:	"Negates a 64-bit integer"
	Author:		"Peter W A Wood"
	Version:	0.1.0
	Rights:		"Copyright © 2014 Peter W A Wood. All rights reserved."
	License:	"Distributed under the Boost Software License, Version 1.0."
	"https://github.com/Red/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %PWAW-I64-int64-def.reds

PWAW-I64-negate: func [
	a				[PWAW-I64-int64!]
	b				[PWAW-I64-int64!]
	return:			[integer!]
	/local
		carry			[integer!]
][
	either 0 = a/least-sig [
		carry: 1
	][
		carry: 0
	]
	b/least-sig: (not a/least-sig) + 1
	b/most-sig: (not a/most-sig) + carry
	PWAW-I64-OKAY
]



