Red/System [
	Title:   "Red/System core library - compare-strings test script"
	Author:  "Peter W A Wood"
	File: 	 %compare-strings-test.reds
	Rights:  "Copyright (C) 2012 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test/quick-test.reds
#include %../core.reds

~~~start-file~~~ "compare-strings"
    
	--test-- "cs-1"
	--assert false = PWAW-C-compare-strings "aa" "a"
	
	--test-- "cs-2"
	--assert false = PWAW-C-compare-strings "ab" "aa"
	
	--test-- "cs-3"
	--assert false = PWAW-C-compare-strings "aa" "ab"
	
	--test-- "cs-4"
	--assert PWAW-C-compare-strings "a" "a"
	
	--test-- "cs-5"
	--assert PWAW-C-compare-strings "" ""
	
	
~~~end-file~~~

