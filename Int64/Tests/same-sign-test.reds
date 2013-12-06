Red/System [
	Title:   "Red/System Int64 same sign? test script"
	Author:  "Peter W A Wood"
	File: 	 %same-sign-test.reds
	Rights:  "Copyright (C) 2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-I64-int64.reds

~~~start-file~~~ "same-sign?"
    
    i: declare PWAW-I64-int64!
    j: declare PWAW-I64-int64!
  
  --test-- "ss1"
    i/high:  1
    i/low: as PWAW-I64-uint32! 0 
    j/high:  1
    j/low: as PWAW-I64-uint32! 0
  --assert PWAW-I64-same-sign? i j
  
   --test-- "ss2"
    i/high:  -2
    i/low: as PWAW-I64-uint32! 0 
    j/high:  1
    j/low: as PWAW-I64-uint32! 0
  --assert not PWAW-I64-same-sign? i j
  
   --test-- "ss3"
    i/high:  1
    i/low: as PWAW-I64-uint32! 0 
    j/high:  -1
    j/low: as PWAW-I64-uint32! 0
  --assert not PWAW-I64-same-sign? i j

  --test-- "ss4"
    i/high:  -1
    i/low: as PWAW-I64-uint32! 1 
    j/high:  -1
    j/low: as PWAW-I64-uint32! 0
  --assert PWAW-I64-same-sign? i j
  
~~~end-file~~~

