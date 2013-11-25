Red/System [
	Title:   "Red/System Int64 greater? test script"
	Author:  "Peter W A Wood"
	File: 	 %greater-test.reds
	Rights:  "Copyright (C) 2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-I64-int64.reds

~~~start-file~~~ "greater"
    
    i: declare PWAW-I64-int64!
    j: declare PWAW-I64-int64!
  
  --test-- "g1"
    i/high:  1
    i/low: as PWAW-I64-uint32! 0 
    j/high:  1
    j/low: as PWAW-I64-uint32! 0
  --assert not PWAW-I64-greater? i j
  
   --test-- "g2"
    i/high:  2
    i/low: as PWAW-I64-uint32! 0 
    j/high:  1
    j/low: as PWAW-I64-uint32! 0
  --assert PWAW-I64-greater? i j
  
   --test-- "g3"
    i/high:  1
    i/low: as PWAW-I64-uint32! 0 
    j/high:  2
    j/low: as PWAW-I64-uint32! 0
  --assert not PWAW-I64-greater? i j

~~~end-file~~~

