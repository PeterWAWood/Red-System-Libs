Red/System [
	Purpose:     "Int64 Structure Definition"
	Author:      "Peter W A Wood"
	Version:     0.1.0
	Rights:      "Copyright © 2014 Peter W A Wood. All rights reserved."
	License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

PWAW-I64-int64!: alias struct! [
	least-sig		[integer!]
	most-sig		[integer!]
]

#define	PWAW-I64-OKAY 				0	                
#define PWAW-I64-OVERFLOW			1					;; an int64 overflowed
#define PWAW-I64-INVALID-ARG		2					
#define PWAW-I64-EXCESSIVE-SHIFT	3
#define PWAW-I64-ZERO-DIVIDE		4

#define PWAW-I64-copy(a b) [
	b/least-sig: a/least-sig
	b/most-sig: a/most-sig
]	

#define PWAW-I64-equal?(a b) [
	all [
		a/least-sig = b/least-sig
		a/most-sig = b/most-sig
	]
]

#define PWAW-I64-negative?(i64) [
	(i64/most-sig < 0)
]
                                                    
#define PWAW-I64-positive?(i64) [
	(i64/most-sig >= 0)
]

#define PWAW-I64-return-if(a op b) [
	if a op b [
		return a
	]
]

#define PWAW-I64-zero?(a) [
	all [
		0 = a/least-sig
		0 = a/most-sig
	]
]

#define PWAW-I64-zero-int64(i64) [
	i64/least-sig: 0
	i64/most-sig: 0	
]

PWAW-I64-zero: declare PWAW-I64-int64!
PWAW-I64-zero/least-sig: 0
PWAW-I64-zero/most-sig: 0

PWAW-I64-one: declare PWAW-I64-int64!
PWAW-I64-one/least-sig: 1
PWAW-I64-one/most-sig: 0




