Red/System [
	Title:   "Red/System Int64 library - subtract absolute test script"
	Author:  "Peter W A Wood"
	Rights:  "Copyright (C) 2014 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-I64-abs-sub.reds
#include %../PWAW-I64-greater.reds

~~~start-file~~~ "abs-sub"    

	--test-- "abs-sub-1"
		a: declare PWAW-I64-int64!
		a/least-sig:  0
		a/most-sig: 1
		b: declare PWAW-I64-int64!
		b/least-sig:  0
		b/most-sig: 1
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-sub a b c
		--assert c/least-sig =  0
		--assert c/most-sig = 0
		
	--test-- "abs-sub-2"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 1
		b: declare PWAW-I64-int64!
		b/least-sig:  0
		b/most-sig: 1
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-sub a b c
		--assert c/least-sig =  1
		--assert c/most-sig = 0
	
	--test-- "abs-sub-3"
		a: declare PWAW-I64-int64!
		a/least-sig:  0
		a/most-sig: 1
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-sub a b c
		--assert c/least-sig =  FFFFFFFFh
		--assert c/most-sig = 0

	--test-- "abs-sub-4"
		a: declare PWAW-I64-int64!
		a/least-sig:  0
		a/most-sig: 2
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 1
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-sub a b c
		--assert c/least-sig =  FFFFFFFFh
		--assert c/most-sig = 0
		
	--test-- "abs-sub-5"
		a: declare PWAW-I64-int64!
		a/least-sig:  0
		a/most-sig: -1
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 1
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-INVALID-ARG = PWAW-I64-abs-sub a b c
		--assert c/least-sig =  0
		--assert c/most-sig = 0
		
	--test-- "abs-sub-5"
		a: declare PWAW-I64-int64!
		a/least-sig:  0
		a/most-sig: 1
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 1
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-INVALID-ARG = PWAW-I64-abs-sub a b c
		--assert c/least-sig =  0
		--assert c/most-sig = 0
		
	--test-- "abs-sub-6"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		--assert PWAW-I64-OKAY = PWAW-I64-abs-sub a b a
		--assert a/least-sig =  0
		--assert a/most-sig = 0
		
	--test-- "abs-sub-7"
		a: declare PWAW-I64-int64!
		a/least-sig:  0
		a/most-sig: 1
		b: declare PWAW-I64-int64!
		b/least-sig:  0
		b/most-sig: 1
		--assert PWAW-I64-OKAY = PWAW-I64-abs-sub a b a
		--assert a/least-sig =  0
		--assert a/most-sig = 0
		
	--test-- "abs-sub-8"
		a: declare PWAW-I64-int64!
		a/least-sig:  49F49F4Ah
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  40000000h
		b/most-sig: 0
		--assert PWAW-I64-OKAY = PWAW-I64-abs-sub a b a
		--assert a/least-sig =  09F49F4Ah
		--assert a/most-sig = 0
		
	--test-- "abs-sub-8"
		a: declare PWAW-I64-int64!
		a/least-sig:  49F49F4Ah
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  40000000h
		b/most-sig: 0
		--assert PWAW-I64-OKAY = PWAW-I64-abs-sub a b a
		--assert a/least-sig =  09F49F4Ah
		--assert a/most-sig = 0
			
~~~end-file~~~

