Red/System [
	Purpose:	"Checks one 64-bit integer is greater than another"
	Author:		"Peter W A Wood"
	Version:	0.1.0
	Rights:		"Copyright © 2014 Peter W A Wood. All rights reserved."
	License:	"Distributed under the Boost Software License, Version 1.0."
	"https://github.com/Red/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %PWAW-I64-int64-def.reds

PWAW-I64-greater?: func [
	a				[PWAW-I64-int64!]
	b				[PWAW-I64-int64!]
	return:			[logic!]
][
	case [
		
		all [
			PWAW-I64-negative?(a)
			PWAW-I64-positive?(b)
		][						
			false
		]
	
		all [
			PWAW-I64-positive?(a)
			PWAW-I64-negative?(b)
		][						
			true
		]
		
		a/most-sig > b/most-sig [
			true
		]
		
		b/most-sig > a/most-sig [
			false
		]
		
		(as int-ptr! a/least-sig) > (as int-ptr! b/least-sig) [
			true
		]
		
		true [false]
	]
]



