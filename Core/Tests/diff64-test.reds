Red/System [
	Title:   "Red/System core library - diff64 test script"
	Author:  "Peter W A Wood"
	File: 	 %diff64-test.reds
	Rights:  "Copyright (C) 2012 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test/quick-test.reds
#include %../core.reds

#define init-r1 [r1/high: 0 r1/low: 0]

~~~start-file~~~ "diff64"
    
    i1: declare PWAW-C-int64!
    i2: declare PWAW-C-int64!
    r1: declare PWAW-C-int64!

	--test-- "d64-1"
	  i1/high: 0
	  i1/low:  1
	  i2/high: 0
	  i2/low: 0
	  init-r1
	--assert 0 = PWAW-C-diff64 i1 i2 r1
	--assert 0 = r1/high
	--assert 1 = r1/low
	
	--test-- "d64-2"
	  i1/high: -1
	  i1/low:  0
	  i2/high: 0
	  i2/low: 1
	  init-r1
	--assert 1 = PWAW-C-diff64 i1 i2 r1
	--assert 0 = r1/high
	--assert 0 = r1/low
	
	--test-- "d64-3"
	  i1/high: 0
	  i1/low:  0
	  i2/high: -1
	  i2/low: 1
	  init-r1
	--assert 1 = PWAW-C-diff64 i1 i2 r1
	--assert 0 = r1/high
	--assert 0 = r1/low
	
	--test-- "d64-4"
	  i1/high: 0
	  i1/low:  0
	  i2/high: 0
	  i2/low: 1
	  init-r1
	--assert 2 = PWAW-C-diff64 i1 i2 r1
	--assert 0 = r1/high
	--assert 0 = r1/low 

  --test-- "d64-5"
	  i1/high: 0
	  i1/low:  0
	  i2/high: 0
	  i2/low: FFFFFFFFh
	  init-r1
	--assert 2 = PWAW-C-diff64 i1 i2 r1
	--assert 0 = r1/high
	--assert 0 = r1/low
	
	--test-- "d64-6"
	  i1/high: 0
	  i1/low:  FFFFFFFFh
	  i2/high: 0
	  i2/low:  FFFFFFFFh
	  init-r1
	--assert 0 = PWAW-C-diff64 i1 i2 r1
	--assert 0 = r1/high
	--assert 0 = r1/low
	
	--test-- "d64-7"
	  i1/high: 1
	  i1/low:  FFFFFFFFh
	  i2/high: 0
	  i2/low:  FFFFFFFFh
	  init-r1
	--assert 0 = PWAW-C-diff64 i1 i2 r1
	--assert 1 = r1/high
	--assert 0 = r1/low
	
	--test-- "d64-8"
	  i1/high: 1
	  i1/low:  FFFFFFFEh
	  i2/high: 0
	  i2/low:  FFFFFFFFh
	  init-r1
	--assert 0 = PWAW-C-diff64 i1 i2 r1
	--assert 1 = r1/high
	--assert FFFFFFFFh = r1/low
	
	--test-- "d64-9"
	  i1/high: 1
	  i1/low:  FFFFFFFFh
	  i2/high: 0
	  i2/low:  0
	  init-r1
	--assert 0 = PWAW-C-diff64 i1 i2 r1
	--assert 1 = r1/high
	--assert FFFFFFFFh = r1/low
	
~~~end-file~~~

