Red/System [
	Title:   "Red/System Int64 library - shift right test script"
	Author:  "Peter W A Wood"
	Rights:  "Copyright (C) 2014 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-I64-shift-right.reds

~~~start-file~~~ "shift-right"    

	--test-- "shift-right-1"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-shift-right a b 1
		--assert b/least-sig =  0
		--assert b/most-sig = 0
		
	--test-- "shift-right-2"
		a: declare PWAW-I64-int64!
		a/least-sig:  15
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-shift-right a b 3
		--assert b/least-sig =  1
		--assert b/most-sig = 0
		
	--test-- "shift-right-3"
		a: declare PWAW-I64-int64!
		a/least-sig:  0
		a/most-sig: 1
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-shift-right a b 1
		--assert b/least-sig =  80000000h
		--assert b/most-sig = 0
		
	--test-- "shift-right-4"
		a: declare PWAW-I64-int64!
		a/least-sig:  0
		a/most-sig: 1
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-shift-right a b 9
		--assert b/least-sig =  00800000h
		--assert b/most-sig = 0
		
	--test-- "shift-right-5"
		a: declare PWAW-I64-int64!
		a/least-sig:  0
		a/most-sig: 2
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-shift-right a b 2
		--assert b/least-sig =  80000000h
		--assert b/most-sig = 0
				
	--test-- "shift-right-6"
		a: declare PWAW-I64-int64!
		a/least-sig:  0
		a/most-sig: 2
		b: declare PWAW-I64-int64!
		--assert PWAW-I64-EXCESSIVE-SHIFT = PWAW-I64-shift-right a b 64
		
	--test-- "shift-right-7"
		a: declare PWAW-I64-int64!
		a/least-sig:  0
		a/most-sig: 1
		--assert PWAW-I64-OKAY = PWAW-I64-shift-right a a 1
		--assert a/least-sig =  80000000h
		--assert a/most-sig = 0
		
	--test-- "shift-right-8"
		a: declare PWAW-I64-int64!
		a/least-sig:  0
		a/most-sig: 1
		--assert PWAW-I64-OKAY = PWAW-I64-shift-right a a 0
		--assert a/least-sig =  0
		--assert a/most-sig = 1
		
	--test-- "shift-right-9"
		a: declare PWAW-I64-int64!
		a/least-sig:  80000000h
		a/most-sig: 0
		--assert PWAW-I64-OKAY = PWAW-I64-shift-right a a 1
		--assert a/least-sig =  40000000h
		--assert a/most-sig = 0
		
	--test-- "shift-right-10"
		a: declare PWAW-I64-int64!
		a/least-sig:  0
		a/most-sig: 80000000h
		--assert PWAW-I64-OKAY = PWAW-I64-shift-right a a 63
		--assert a/least-sig =  1
		--assert a/most-sig = 0

~~~end-file~~~

