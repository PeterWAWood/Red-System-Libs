Red/System [
	Title:   "Red/System core library - str-copy test script"
	Author:  "Peter W A Wood"
	File: 	 %str-copy-test.reds
	Rights:  "Copyright (C) 2012 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test/quick-test.reds
#include %../core.reds

~~~start-file~~~ "str-copy"
    
	--test-- "sc-1"
	  s: ""
	--assert 0 = PWAW-C-str-copy "" s
	--assert PWAW-C-compare-strings "" s
	
	--test-- "sc-2"
	  s: ""
	--assert 1 = PWAW-C-str-copy " " s
	
	--test-- "sc-3"
	  s: "abcdefgh"
	--assert 0 = PWAW-C-str-copy " " s
	--assert PWAW-C-compare-strings " " s
	
	--test-- "sc-4"
	  s: "abcde"
	--assert 0 = PWAW-C-str-copy "12345" s
	--assert PWAW-C-compare-strings "12345" s
	
~~~end-file~~~

