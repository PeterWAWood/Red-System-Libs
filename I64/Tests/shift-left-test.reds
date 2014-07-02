Red/System [
	Title:   "Red/System Int64 library - shift left test script"
	Author:  "Peter W A Wood"
	Rights:  "Copyright (C) 2014 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-I64-shift-left.reds

~~~start-file~~~ "shift-left"    

	--test-- "shift-left-1"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-shift-left a b 1
		--assert b/least-sig =  2
		--assert b/most-sig = 0
		
	--test-- "shift-left-2"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-shift-left a b 3
		--assert b/least-sig =  8
		--assert b/most-sig = 0
		
	--test-- "shift-left-3"
		a: declare PWAW-I64-int64!
		a/least-sig:  80000000h
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-shift-left a b 1
		--assert b/least-sig =  0
		--assert b/most-sig = 1
	
	--test-- "shift-left-4"
		a: declare PWAW-I64-int64!
		a/least-sig:  00800000h
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-shift-left a b 9
		--assert b/least-sig =  0
		--assert b/most-sig = 1
		
	--test-- "shift-left-5"
		a: declare PWAW-I64-int64!
		a/least-sig:  80000000h
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-shift-left a b 2
		--assert b/least-sig =  0
		--assert b/most-sig = 2
		
	--test-- "shift-left-6"
		a: declare PWAW-I64-int64!
		a/least-sig:  0
		a/most-sig: 2
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-EXCESSIVE-SHIFT = PWAW-I64-shift-left a b 64
		
	--test-- "shift-left-7"
		a: declare PWAW-I64-int64!
		a/least-sig:  40000000h
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-shift-left a b 1
		--assert b/least-sig =  80000000h
		--assert b/most-sig = 0
		
	--test-- "shift-left-8"
		a: declare PWAW-I64-int64!
		a/least-sig:  40000000h
		a/most-sig: 0
		--assert PWAW-I64-OKAY = PWAW-I64-shift-left a a 1
		--assert a/least-sig =  80000000h
		--assert a/most-sig = 0
		
	--test-- "shift-left-9"
		a: declare PWAW-I64-int64!
		a/least-sig:  40000000h
		a/most-sig: 0
		--assert PWAW-I64-OKAY = PWAW-I64-shift-left a a 0
		--assert a/least-sig =  40000000h
		--assert a/most-sig = 0
		
	--test-- "shift-left-10"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 0
		--assert PWAW-I64-OKAY = PWAW-I64-shift-left a a 0
		--assert a/least-sig =  1
		--assert a/most-sig = 0
		
	--test-- "shift-left-11"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-shift-left a b 0
		--assert b/least-sig =  1
		--assert b/most-sig = 0
		
	--test-- "shift-left-12"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-shift-left a b 31
		--assert b/least-sig =  80000000h
		--assert b/most-sig = 0
		
	--test-- "shift-left-13"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 0
		--assert PWAW-I64-OKAY = PWAW-I64-shift-left a a 63
		--assert a/least-sig =  0
		--assert a/most-sig = 80000000h
		
	--test-- "shift-left-14"
		a: declare PWAW-I64-int64!
		a/least-sig:  A0000000h
		a/most-sig: 0
		--assert PWAW-I64-OKAY = PWAW-I64-shift-left a a 1
		--assert a/least-sig =  40000000h
		--assert a/most-sig = 1
		
	--test-- "shift-left-15"
		a: declare PWAW-I64-int64!
		a/least-sig:  A0000000h
		a/most-sig: 0
		--assert PWAW-I64-OKAY = PWAW-I64-shift-left a a 2
		--assert a/least-sig =  80000000h
		--assert a/most-sig = 2

~~~end-file~~~

