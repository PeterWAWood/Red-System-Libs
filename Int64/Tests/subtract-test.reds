Red/System [
	Title:   "Red/System Int64 Subtraction test script"
	Author:  "Peter W A Wood"
	File: 	 %subtract-test.reds
	Rights:  "Copyright (C) 2012 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test/quick-test.reds
#include %../int64.reds

~~~start-file~~~ "subtract"
    
    i: declare PWAW-C-int64!
    j: declare PWAW-C-int64!
    k: declare PWAW-C-int64!
  
  --test-- "s1"
    i/low:  1
    i/high: 0
    j/low:  0
    j/high: 0
  --assert 0 = PWAW-I64-sub i j k
  --assert 1 = k/low
  --assert 0 = k/high
  
  --test-- "s2"
    i/low:  1
    i/high: 1
    j/low:  1
    j/high: 1
  --assert 0 = PWAW-I64-sub i j k
  --assert 0 = k/low
  --assert 0 = k/high
  
  --test-- "s3"
    i/low:  FFFFFFFFh
    i/high: 0
    j/low:  1
    j/high: 0
  --assert 0 = PWAW-I64-sub i j k
  --assert FFFFFFFEh = k/low
  --assert 0 = k/high
    
~~~end-file~~~

