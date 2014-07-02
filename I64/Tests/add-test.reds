Red/System [
	Title:   "Red/System Int64 library - add test script"
	Author:  "Peter W A Wood"
	Rights:  "Copyright (C) 2014 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-I64-add.reds

~~~start-file~~~ "add"    

	--test-- "add-1"
		a: declare PWAW-I64-int64!
		a/least-sig:  0
		a/most-sig: 1
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-add a b c
		--assert c/least-sig =  1
		--assert c/most-sig = 1
				
	--test-- "add-2"
		a: declare PWAW-I64-int64!
		a/least-sig:  FFFFFFFFh
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-add a b c
		--assert c/least-sig =  0
		--assert c/most-sig = 1
		
	--test-- "add-3"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-add a b c
		--assert c/least-sig =  2
		--assert c/most-sig = 0
		
	--test-- "add-4"
		a: declare PWAW-I64-int64!
		a/least-sig:  FFFFFFFFh
		a/most-sig: 7FFFFFFFh
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OVERFLOW = PWAW-I64-add a b c
		--assert c/least-sig =  0
		--assert c/most-sig = 80000000h
		
	--test-- "add-5"
		a: declare PWAW-I64-int64!
		a/least-sig:  FFFFFFFFh
		a/most-sig: 7FFFFFFFh
		b: declare PWAW-I64-int64!
		b/least-sig:  2
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OVERFLOW = PWAW-I64-add a b c
		--assert c/least-sig =  1
		--assert c/most-sig = 80000000h
	
	--test-- "add-6"
		a: declare PWAW-I64-int64!
		a/least-sig:  2
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  FFFFFFFFh
		b/most-sig: FFFFFFFFh
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-add a b c
		--assert c/least-sig =  1
		--assert c/most-sig = 0
		
	--test-- "add-7"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  FFFFFFFEh
		b/most-sig: FFFFFFFFh
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-add a b c
		--assert c/least-sig =  FFFFFFFFh
		--assert c/most-sig = FFFFFFFFh
		
	--test-- "add-8"
		a: declare PWAW-I64-int64!
		a/least-sig:  FFFFFFFFh
		a/most-sig: FFFFFFFFh
		b: declare PWAW-I64-int64!
		b/least-sig:  FFFFFFFFh
		b/most-sig: FFFFFFFFh
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-add a b c
		--assert c/least-sig =  FFFFFFFEh
		--assert c/most-sig = FFFFFFFFh
		
	--test-- "add-9"
		a: declare PWAW-I64-int64!
		a/least-sig:  FFFFFFFFh
		a/most-sig: 7FFFFFFFh
		b: declare PWAW-I64-int64!
		b/least-sig:  2
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OVERFLOW = PWAW-I64-add a b c
				
~~~end-file~~~

