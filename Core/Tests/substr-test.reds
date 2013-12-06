Red/System [
	Title:   "Red/System core library - substr test script"
	Author:  "Peter W A Wood"
	File: 	 %substr-test.reds
	Rights:  "Copyright (C) 2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-C-core.reds

~~~start-file~~~ "substr"

	--test-- "ss1"
		ss1-str: ""
	--assert 1 = PWAW-C-substr "abcde" 1 3 ss1-str
    
	--test-- "ss2"
		ss1-str: "                    "
	--assert 2 = PWAW-C-substr "abcde" 5 3 ss1-str
	
	--test-- "ss3"
		ss1-str: "                    "
	--assert 2 = PWAW-C-substr "abcde" 0 3 ss1-str
	
	--test-- "ss4"
		ss1-str: "                    "
	--assert 2 = PWAW-C-substr "abcde" 6 3 ss1-str

	--test-- "ss5"
		ss-str: "                    "
	--assert 0 = PWAW-C-substr "abcde" 1 3 ss-str
	--assert PWAW-C-str-equal? "abc" ss-str
	--assert 3 = length? ss-str
	--assert 4 = size? ss-str
	
	--test-- "ss5"
		ss-str: "                    "
	--assert 0 = PWAW-C-substr "abcde" 5 1 ss-str
	--assert PWAW-C-str-equal? "e" ss-str
	--assert 1 = length? ss-str
	--assert 2 = size? ss-str
	
~~~end-file~~~

