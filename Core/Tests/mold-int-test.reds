Red/System [
	Title:   "Red/System core library - mold-int test script"
	Author:  "Peter W A Wood"
	File: 	 %mold-int-test.reds
	Rights:  "Copyright (C) 2012 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test/quick-test.reds
#include %../core.reds

~~~start-file~~~ "mold-int"
    
	--test-- "mi-1"
	  mi: "abcdefghijk"
	--assert 0 = PWAW-C-mold-int 0 mi
	--assert PWAW-C-compare-strings "0" mi
	
	--test-- "mi-2"
	  mi: ""
	--assert 1 = PWAW-C-mold-int 0 mi
	--assert PWAW-C-compare-strings "" mi
	
	--test-- "mi-3"  
	  mi: "abcdefghijk"
  --assert 0 = PWAW-C-mold-int -2147483648 mi
  --assert PWAW-C-compare-strings "-2147483648" mi
  
  --test-- "mi-4"  
	  mi: "abcdefghij"
  --assert 1 = PWAW-C-mold-int -2147483648 mi
  --assert PWAW-C-compare-strings "abcdefghij" mi
  
  --test-- "mi-5"	  
	  mi: "abcdefghijk"
	--assert 0 = PWAW-C-mold-int 2147483647 mi
  --assert PWAW-C-compare-strings "2147483647" mi
  
  --test-- "mi-6"	  
	  mi: "abcdefghijk"
	--assert 0 = PWAW-C-mold-int 1 mi
  --assert PWAW-C-compare-strings "1" mi
  
  --test-- "mi-7"	  
	  mi: "abcdefghijk"
	--assert 0 = PWAW-C-mold-int -1 mi
  --assert PWAW-C-compare-strings "-1" mi
	
  --test-- "mi-8"	  
	  mi: "abcdefghijk"
	--assert 0 = PWAW-C-mold-int 10 mi
  --assert PWAW-C-compare-strings "10" mi
  
  --test-- "mi-9"	  
	  mi: "abcdefghijk"
	--assert 0 = PWAW-C-mold-int -5 mi
  --assert PWAW-C-compare-strings "-5" mi
	
~~~end-file~~~

