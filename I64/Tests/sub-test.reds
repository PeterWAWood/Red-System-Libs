Red/System [
	Title:   "Red/System Int64 library - sub test script"
	Author:  "Peter W A Wood"
	Rights:  "Copyright (C) 2014 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-I64-sub.reds

~~~start-file~~~ "sub"    

	--test-- "sub-1"
		a: declare PWAW-I64-int64!
		a/least-sig:  0
		a/most-sig: 1
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-sub a b c
		--assert c/least-sig =  FFFFFFFFh
		--assert c/most-sig = 0
				
	--test-- "sub-2"
		a: declare PWAW-I64-int64!
		a/least-sig:  FFFFFFFFh
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-sub a b c
		--assert c/least-sig =  FFFFFFFEh
		--assert c/most-sig = 0
		
	--test-- "sub-3"
		a: declare PWAW-I64-int64!
		a/least-sig:  100
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-sub a b c
		--assert c/least-sig =  99
		--assert c/most-sig = 0
		
	--test-- "sub-4"
		a: declare PWAW-I64-int64!
		a/least-sig:  FFFFFFFFh
		a/most-sig: 7FFFFFFFh
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-sub a b c
		--assert c/least-sig =  FFFFFFFEh
		--assert c/most-sig = 7FFFFFFFh
		
	--test-- "sub-5"
		a: declare PWAW-I64-int64!
		a/least-sig:  FFFFFFFFh
		a/most-sig: 7FFFFFFFh
		b: declare PWAW-I64-int64!
		b/least-sig:  FFFFFFFEh
		b/most-sig: FFFFFFFFh
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OVERFLOW = PWAW-I64-sub a b c
	
	--test-- "sub-6"
		a: declare PWAW-I64-int64!
		a/least-sig:  2
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  FFFFFFFFh
		b/most-sig: FFFFFFFFh
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-sub a b c
		--assert c/least-sig =  3
		--assert c/most-sig = 0
		
	--test-- "sub-7"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  FFFFFFFEh
		b/most-sig: FFFFFFFFh
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-sub a b c
		--assert c/least-sig =  3
		--assert c/most-sig = 0
		
	--test-- "sub-8"
		a: declare PWAW-I64-int64!
		a/least-sig:  FFFFFFFFh
		a/most-sig: FFFFFFFFh
		b: declare PWAW-I64-int64!
		b/least-sig:  FFFFFFFFh
		b/most-sig: FFFFFFFFh
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-sub a b c
		--assert c/least-sig =  0
		--assert c/most-sig = 0
				
~~~end-file~~~

