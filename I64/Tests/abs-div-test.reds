Red/System [
	Title:   "Red/System Int64 library - absolute divide test script"
	Author:  "Peter W A Wood"
	Rights:  "Copyright (C) 2014 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-I64-abs-div.reds

~~~start-file~~~ "abs-div"   

	--test-- "abs-div-1"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		d: declare PWAW-I64-int64!
		r: PWAW-I64-abs-div a b c d
		--assert PWAW-I64-OKAY = r
		--assert c/least-sig =  1
		--assert c/most-sig = 0
		--assert d/least-sig =  0
		--assert d/most-sig = 0
					
	--test-- "abs-div-2"
		a: declare PWAW-I64-int64!
		a/least-sig:  FFFFFFFFh
		a/most-sig: 7FFFFFFFh
		b: declare PWAW-I64-int64!
		b/least-sig:  0
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		d: declare PWAW-I64-int64!
		--assert PWAW-I64-ZERO-DIVIDE = PWAW-I64-abs-div a b c d
		
	--test-- "abs-div-3"
		a: declare PWAW-I64-int64!
		a/least-sig:  00000000h
		a/most-sig: 1
		b: declare PWAW-I64-int64!
		b/least-sig:  2
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		d: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-div a b c d
		--assert c/least-sig =  80000000h
		--assert c/most-sig = 0
		--assert d/least-sig =  0
		--assert d/most-sig = 0
				
	--test-- "abs-div-4"
		a: declare PWAW-I64-int64!
		a/least-sig:  0
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  0
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		d: declare PWAW-I64-int64!
		--assert PWAW-I64-ZERO-DIVIDE = PWAW-I64-abs-div a b c d
	
	--test-- "abs-div-5"
		a: declare PWAW-I64-int64!
		a/least-sig:  2
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		d: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-div a b c d
		--assert c/least-sig =  2
		--assert c/most-sig = 0
		--assert d/least-sig =  0
		--assert d/most-sig = 0
			
	--test-- "abs-div-6"
		a: declare PWAW-I64-int64!
		a/least-sig:  2
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  2
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		d: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-div a b c d
		--assert c/least-sig =  1
		--assert c/most-sig = 0
		--assert d/least-sig =  0
		--assert d/most-sig = 0
		
	--test-- "abs-div-7"
		a: declare PWAW-I64-int64!
		a/least-sig:  87654321h
		a/most-sig: 00000000h
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		d: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-div a b c d
		--assert c/least-sig =  87654321h
		--assert c/most-sig = 0
		--assert d/least-sig =  0
		--assert d/most-sig = 0
	
	--test-- "abs-div-8"
		a: declare PWAW-I64-int64!
		a/least-sig:  21
		a/most-sig: 00000000h
		b: declare PWAW-I64-int64!
		b/least-sig:  21
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		d: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-div a b c d
		--assert c/least-sig =  1
		--assert c/most-sig = 0
		--assert d/least-sig =  0
		--assert d/most-sig = 0

	--test-- "abs-div-9"
		a: declare PWAW-I64-int64!
		a/least-sig:  49F49F4Ah
		a/most-sig: 00000005h
		b: declare PWAW-I64-int64!
		b/least-sig:  10
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		d: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-div a b c d
		--assert c/least-sig =  87654321h
		--assert c/most-sig = 00000000h
		--assert d/least-sig =  0
		--assert d/most-sig = 0 
		
	--test-- "abs-div-10"
		a: declare PWAW-I64-int64!
		a/least-sig:  93E93E94h
		a/most-sig: 0000000Ah
		b: declare PWAW-I64-int64!
		b/least-sig:  20
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		d: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-div a b c d
		--assert c/least-sig =  87654321h
		--assert c/most-sig = 00000000h
		--assert d/least-sig =  0
		--assert d/most-sig = 0
		
	--test-- "abs-div-11"
		a: declare PWAW-I64-int64!
		a/least-sig:  1B4E81B5h
		a/most-sig: 0000000Bh
		b: declare PWAW-I64-int64!
		b/least-sig:  21
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		d: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-div a b c d
		--assert c/least-sig =  87654321h
		--assert c/most-sig = 00000000h
		--assert d/least-sig =  0
		--assert d/most-sig = 0
		
	--test-- "abs-div-12"
		a: declare PWAW-I64-int64!
		a/least-sig:  B7A44A41h
		a/most-sig: 37AF4C76h
		b: declare PWAW-I64-int64!
		b/least-sig:  77654321h
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		d: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-div a b c d
		--assert c/least-sig =  77654321h
		--assert c/most-sig = 00000000h
		--assert d/least-sig =  0
		--assert d/most-sig = 0
		
	--test-- "abs-div-13"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  2
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		d: declare PWAW-I64-int64!
		--assert PWAW-I64-OKAY = PWAW-I64-abs-div a b c d
		--assert c/least-sig =  0
		--assert c/most-sig = 0
		--assert d/least-sig =  1
		--assert d/most-sig = 0
		
	--test-- "abs-div-14"
		a: declare PWAW-I64-int64!
		a/least-sig:  D7A44A41h
		a/most-sig: 479BF4DAh
		b: declare PWAW-I64-int64!
		b/least-sig:  87654321h
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		d: declare PWAW-I64-int64!
		r: PWAW-I64-abs-div a b c d
		--assert PWAW-I64-OKAY = r
		--assert c/least-sig =  87654321h
		--assert c/most-sig = 00000000h
		--assert d/least-sig =  0
		--assert d/most-sig = 0

~~~end-file~~~

