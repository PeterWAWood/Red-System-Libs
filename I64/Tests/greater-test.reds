Red/System [
	Title:   "Red/System Int64 library - greater test script"
	Author:  "Peter W A Wood"
	Rights:  "Copyright (C) 2014 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-I64-greater.reds

~~~start-file~~~ "greater?"    

	--test-- "greater-1"	
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 1
		b: declare PWAW-I64-int64!
		b/least-sig:  0
		b/most-sig: 1
		--assert PWAW-I64-greater? a b
		--assert a/least-sig =  1
		--assert b/least-sig =  0
		--assert a/most-sig = 1
		--assert b/most-sig = 1
		
	--test-- "greater-2"
		a: declare PWAW-I64-int64!
		a/least-sig:  FFFFFFFFh
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  0
		b/most-sig: 1
		--assert not PWAW-I64-greater? a b
		
	--test-- "greater-3"
		a: declare PWAW-I64-int64!
		a/least-sig:  1
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  1
		b/most-sig: 0
		--assert not PWAW-I64-greater? a b
		
	--test-- "greater-4"
		a: declare PWAW-I64-int64!
		a/least-sig:  40000000h
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  49F49F4Ah
		b/most-sig: 0
		--assert not PWAW-I64-greater? a b
		
	--test-- "greater-5"
		a: declare PWAW-I64-int64!
		a/least-sig:  A0000000h
		a/most-sig: 0
		b: declare PWAW-I64-int64!
		b/least-sig:  49F49F4Ah
		b/most-sig: 0
		--assert PWAW-I64-greater? a b
		
~~~end-file~~~

