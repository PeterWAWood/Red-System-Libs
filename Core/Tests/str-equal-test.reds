Red/System [
	Title:   "Red/System core library - str-equal? test script"
	Author:  "Peter W A Wood"
	File: 	 %str-equal?-test.reds
	Rights:  "Copyright (C) 2012 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-C-core.reds

~~~start-file~~~ "str-equal?"
    
	--test-- "cs-1"
	--assert false = PWAW-C-str-equal? "aa" "a"
	
	--test-- "cs-2"
	--assert false = PWAW-C-str-equal? "ab" "aa"
	
	--test-- "cs-3"
	--assert false = PWAW-C-str-equal? "aa" "ab"
	
	--test-- "cs-4"
	--assert PWAW-C-str-equal? "a" "a"
	
	--test-- "cs-5"
	--assert PWAW-C-str-equal? "" ""
	
	
~~~end-file~~~

