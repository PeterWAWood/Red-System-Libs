Red/System [
	Title:   "Red/System Int64 base add test script"
	Author:  "Peter W A Wood"
	File: 	 %base-add-test.reds
	Rights:  "Copyright (C) 2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-I64-int64.reds

~~~start-file~~~ "base-add"
    
    i: declare PWAW-I64-int64!
    j: declare PWAW-I64-int64!
    k: declare PWAW-I64-int64!
    
  --test-- "ba1"
    i/high:  1
    i/low: as PWAW-I64-uint32! 0 
    j/high:  1
    j/low: as PWAW-I64-uint32! 0
  --assert 0 = PWAW-I64-base-add i j k
  --assert 2 = k/high
  --assert (as PWAW-I64-uint32! 0) = k/low
  
   --test-- "ba2"
    i/high:  2
    i/low: as PWAW-I64-uint32! 0 
    j/high:  1
    j/low: as PWAW-I64-uint32! 0
  --assert 0 = PWAW-I64-base-add i j k
  --assert 3 = k/high
  --assert (as PWAW-I64-uint32! 0) = k/low
  
   --test-- "ba3"
    i/high:  1
    i/low: as PWAW-I64-uint32! 1 
    j/high:  1
    j/low: as PWAW-I64-uint32! 0
  --assert 0 = PWAW-I64-base-add i j k
  --assert 2 = k/high
  --assert (as PWAW-I64-uint32! 1) = k/low
  
  --test-- "ba4"
    i/high: 1
    i/low: as PWAW-I64-uint32! FFFFFFFFh 
    j/high: 1
    j/low: as PWAW-I64-uint32! FFFFFFFEh
  --assert 0 = PWAW-I64-base-add i j k
  --assert 3 = k/high
  --assert (as PWAW-I64-uint32! FFFFFFFDh) = k/low
  
~~~end-file~~~

