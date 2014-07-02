Red/System [
	Title:   "Red/System Int64 library - absolute mulide test script"
	Author:  "Peter W A Wood"
	Rights:  "Copyright (C) 2014 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-I64-mul.reds

~~~start-file~~~ "mul"    

	--test-- "mul-1"
		a: declare PWAW-I64-int64!
		a/least-sig:  2
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		r: PWAW-I64-mul a b c 
		--assert PWAW-I64-OKAY = r
		--assert c/least-sig =  2
		--assert c/most-sig = 0
		
	--test-- "mul-2"
		a: declare PWAW-I64-int64!
		a/least-sig:  FFFFFFFEh
		a/most-sig: FFFFFFFFh
		b: declare PWAW-I64-int64!
		b/least-sig:  2
		b/most-sig: 0
		c: declare PWAW-I64-int64!
		r: PWAW-I64-mul a b c 
		--assert PWAW-I64-OKAY = r
		--assert c/least-sig =  FFFFFFFCh
		--assert c/most-sig = FFFFFFFFh
		
	--test-- "mul-3"
		a: declare PWAW-I64-int64!
		a/least-sig:  FFFFFFFEh
		a/most-sig: FFFFFFFFh
		b: declare PWAW-I64-int64!
		b/least-sig:  FFFFFFFFh
		b/most-sig: FFFFFFFFh
		c: declare PWAW-I64-int64!
		r: PWAW-I64-mul a b c 
		--assert PWAW-I64-OKAY = r
		--assert c/least-sig =  2
		--assert c/most-sig = 0
	 
	--test-- "mul-4"
		a: declare PWAW-I64-int64!
		a/least-sig:  2
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  FFFFFFFEh
		b/most-sig: FFFFFFFFh
		c: declare PWAW-I64-int64!
		r: PWAW-I64-mul a b c
		--assert PWAW-I64-OKAY = r
		--assert c/least-sig =  FFFFFFFCh
		--assert c/most-sig = FFFFFFFFh
		
~~~end-file~~~

