Red/System [
	Title:   "Red/System Int64 library - multiply absolute test script"
	Author:  "Peter W A Wood"
	Rights:  "Copyright (C) 2014 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-I64-abs-mul.reds

~~~start-file~~~ "abs-mul"    

	--test-- "abs-mul-1"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-mul a b c
		--assert c/least-sig =  1
		--assert c/most-sig = 0
		
		
	--test-- "abs-mul-2"
		a: declare PWAW-I64-int64!
		a/least-sig:  FFFFFFFFh
		a/most-sig: 7FFFFFFFh
		b: declare PWAW-I64-int64!
		b/least-sig:  FFFFFFFFh
		b/most-sig: 7FFFFFFFh
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OVERFLOW = PWAW-I64-abs-mul a b c
		
	--test-- "abs-mul-3"
		a: declare PWAW-I64-int64!
		a/least-sig:  80000000h
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  2
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-mul a b c
		--assert c/least-sig =  00000000h
		--assert c/most-sig = 00000001h
		
	--test-- "abs-mul-4"
		a: declare PWAW-I64-int64!
		a/least-sig:  0
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  0
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-mul a b c
		--assert c/least-sig =  0
		--assert c/most-sig = 0
		
	--test-- "abs-mul-5"
		a: declare PWAW-I64-int64!
		a/least-sig:  2
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-mul a b c
		--assert c/least-sig =  2
		--assert c/most-sig = 0
		
	--test-- "abs-mul-6"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  2
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-mul a b c
		--assert c/least-sig =  2
		--assert c/most-sig = 0
		
	--test-- "abs-mul-7"
		a: declare PWAW-I64-int64!
		a/least-sig:  87654321h
		a/most-sig: 00000000h
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-mul a b c
		--assert c/least-sig =  87654321h
		--assert c/most-sig = 0
		
	--test-- "abs-mul-8"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 00000000h
		b: declare PWAW-I64-int64!
		b/least-sig:  21
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-mul a b c
		--assert c/least-sig =  21
		--assert c/most-sig = 0
		
	--test-- "abs-mul-9"
		a: declare PWAW-I64-int64!
		a/least-sig:  87654321h
		a/most-sig: 00000000h
		b: declare PWAW-I64-int64!
		b/least-sig:  10
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-mul a b c
		--assert c/least-sig =  49F49F4Ah
		--assert c/most-sig = 00000005h
		
	--test-- "abs-mul-10"
		a: declare PWAW-I64-int64!
		a/least-sig:  87654321h
		a/most-sig: 00000000h
		b: declare PWAW-I64-int64!
		b/least-sig:  20
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-mul a b c
		--assert c/least-sig =  93E93E94h
		--assert c/most-sig = 0000000Ah
		
	--test-- "abs-mul-11"
		a: declare PWAW-I64-int64!
		a/least-sig:  87654321h
		a/most-sig: 00000000h
		b: declare PWAW-I64-int64!
		b/least-sig:  21
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-mul a b c
		--assert c/least-sig =  1B4E81B5h
		--assert c/most-sig = 0000000Bh
		
	--test-- "abs-mul-12"
		a: declare PWAW-I64-int64!
		a/least-sig:  87654321h
		a/most-sig: 00000000h
		b: declare PWAW-I64-int64!
		b/least-sig:  87654321h
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-mul a b c
		--assert c/least-sig =  D7A44A41h
		--assert c/most-sig = 479BF4DAh
		
~~~end-file~~~

