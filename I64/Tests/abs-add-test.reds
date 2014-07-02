Red/System [
	Title:   "Red/System Int64 library - absolute add test script"
	Author:  "Peter W A Wood"
	Rights:  "Copyright (C) 2014 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-I64-abs-add.reds

~~~start-file~~~ "abs-add"    

	--test-- "abs-add-1"
		a: declare PWAW-I64-int64!
		a/least-sig:  0
		a/most-sig: 1
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-add a b c
		--assert c/least-sig =  1
		--assert c/most-sig = 1
				
	--test-- "abs-add-2"
		a: declare PWAW-I64-int64!
		a/least-sig:  FFFFFFFFh
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-add a b c
		--assert c/least-sig =  0
		--assert c/most-sig = 1
	--test-- "abs-add-3"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-add a b c
		--assert c/least-sig =  2
		--assert c/most-sig = 0
		
	--test-- "abs-add-4"
		a: declare PWAW-I64-int64!
		a/least-sig:  FFFFFFFFh
		a/most-sig: 7FFFFFFFh
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OVERFLOW = PWAW-I64-abs-add a b c
		--assert c/least-sig =  0
		--assert c/most-sig = 80000000h
		
	--test-- "abs-add-5"
		a: declare PWAW-I64-int64!
		a/least-sig:  FFFFFFFFh
		a/most-sig: 7FFFFFFFh
		b: declare PWAW-I64-int64!
		b/least-sig:  2
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OVERFLOW = PWAW-I64-abs-add a b c
		--assert c/least-sig =  1
		--assert c/most-sig = 80000000h
		
	--test-- "abs-add-6"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		--assert PWAW-I64-OKAY = PWAW-I64-abs-add a b a
		--assert a/least-sig =  2
		--assert a/most-sig = 0
		
	--test-- "abs-add-7"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 1
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 1
		--assert PWAW-I64-OKAY = PWAW-I64-abs-add a b a
		--assert a/least-sig =  2
		--assert a/most-sig = 2
		
	--test-- "abs-add-8"
		a: declare PWAW-I64-int64!
		a/least-sig:  10000000h
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  80000000h
		b/most-sig: 0
		--assert PWAW-I64-OKAY = PWAW-I64-abs-add a b a
		--assert a/least-sig =  90000000h
		--assert a/most-sig = 0
		
	--test-- "abs-add-9"
		a: declare PWAW-I64-int64!
		a/least-sig:  80000000h
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  04000000h
		b/most-sig: 0
		--assert PWAW-I64-OKAY = PWAW-I64-abs-add a b a
		--assert a/least-sig =  84000000h
		--assert a/most-sig = 0
		
~~~end-file~~~

