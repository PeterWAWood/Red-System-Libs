Red/System [
	Title:   "Red/System Int64 base subtract test script"
	Author:  "Peter W A Wood"
	File: 	 %base-subtract-test.reds
	Rights:  "Copyright (C) 2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-I64-int64.reds

~~~start-file~~~ "base-subtract"
    
    i: declare PWAW-I64-int64!
    j: declare PWAW-I64-int64!
    k: declare PWAW-I64-int64!
    
  --test-- "bs1"
    i/high:  1
    i/low: as PWAW-I64-uint32! 0 
    j/high:  1
    j/low: as PWAW-I64-uint32! 0
  --assert 0 = PWAW-I64-base-subtract i j k
  --assert 0 = k/high
  --assert (as PWAW-I64-uint32! 0) = k/low
  
   --test-- "bs2"
    i/high:  2
    i/low: as PWAW-I64-uint32! 0 
    j/high:  1
    j/low: as PWAW-I64-uint32! 0
  --assert 0 = PWAW-I64-base-subtract i j k
  --assert 1 = k/high
  --assert (as PWAW-I64-uint32! 0) = k/low
  
   --test-- "bs3"
    i/high:  1
    i/low: as PWAW-I64-uint32! 1 
    j/high:  1
    j/low: as PWAW-I64-uint32! 0
  --assert 0 = PWAW-I64-base-subtract i j k
  --assert 0 = k/high
  --assert (as PWAW-I64-uint32! 1) = k/low
  
  --test-- "bs4"
    i/high: 1
    i/low: as PWAW-I64-uint32! FFFFFFFEh 
    j/high: 1
    j/low: as PWAW-I64-uint32! FFFFFFFFh
  --assert 0 = PWAW-I64-base-subtract i j k
  --assert -1 = k/high
  --assert (as PWAW-I64-uint32! FFFFFFFFh) = k/low

  --test-- "bs5"
    i/high: 0
    i/low: as PWAW-I64-uint32! 0
    j/high: 1
    j/low: as PWAW-I64-uint32! 0
  --assert 0 = PWAW-I64-base-subtract i j k
  --assert -1 = k/high
  --assert (as PWAW-I64-uint32! 0) = k/low
  
  --test-- "bs6"
    i/high: 0
    i/low: as PWAW-I64-uint32! 0
    j/high: 0
    j/low: as PWAW-I64-uint32! 5
  --assert 0 = PWAW-I64-base-subtract i j k
  --assert -1 = k/high
  --assert (as PWAW-I64-uint32! FFFFFFFBh) = k/low
  
  
~~~end-file~~~

