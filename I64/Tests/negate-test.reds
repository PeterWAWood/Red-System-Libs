Red/System [
	Title:   "Red/System Int64 library - negate test script"
	Author:  "Peter W A Wood"
	Rights:  "Copyright (C) 2014 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-I64-negate.reds

~~~start-file~~~ "negate"    

	--test-- "negate-1"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-negate a b
		--assert b/least-sig =  FFFFFFFFh
		--assert b/most-sig = FFFFFFFFh

	--test-- "negate-2"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 80000000h
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-negate a b
		--assert b/least-sig =  FFFFFFFFh
		--assert b/most-sig = 7FFFFFFFh
	
	--test-- "negate-3"
		a: declare PWAW-I64-int64!
		a/least-sig:  445566
		a/most-sig: 111222333
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-negate a b
		--assert b/least-sig =  FFF93382h
		--assert b/most-sig = F95EE1C2h

	--test-- "negate-4"
		a: declare PWAW-I64-int64!
		a/least-sig:  445566
		a/most-sig: -111222333
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-negate a b
		--assert b/least-sig =  FFF93382h
		--assert b/most-sig = 06A11E3Ch
		
	--test-- "negate-5"
		a: declare PWAW-I64-int64!
		a/least-sig:  FFFFFFFFh
		a/most-sig: 7FFFFFFFh
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-negate a b
		--assert b/least-sig =  1
		--assert b/most-sig = 80000000h
		
	--test-- "negate-6"
		a: declare PWAW-I64-int64!
		a/least-sig:  2
		a/most-sig: 80000000h
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-negate a b
		--assert b/least-sig =  -2
		--assert b/most-sig = 7FFFFFFFh
		
	--test-- "negate-7"
		a: declare PWAW-I64-int64!
		a/least-sig:  0
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-negate a b
		--assert b/least-sig =  0
		--assert b/most-sig = 0

~~~end-file~~~

