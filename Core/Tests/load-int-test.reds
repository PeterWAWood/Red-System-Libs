Red/System [
	Title:   "Red/System core library - str-int? test script"
	Author:  "Peter W A Wood"
	File: 	 %load-int-test.reds
	Rights:  "Copyright (C) 2012 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-C-core.reds

~~~start-file~~~ "load-int"
    
    li: 0

	--test-- "li-1"
	  li: 0
	--assert 0 = PWAW-C-load-int "1" :li
	--assert 1 = li
	
	--test-- "li-2"
	  li: 999
	--assert 0 = PWAW-C-load-int "0" :li
	--assert 0 = li
	
	--test-- "li-3"
	  li: 0 
	--assert 0 = PWAW-C-load-int "-1" :li
	--assert -1 = li
	
	--test-- "li-4"
	  li: 0 
	--assert 0 = PWAW-C-load-int "2147483647" :li
	--assert 2147483647 = li
	
	--test-- "li-5"
	  li: 0 
	--assert 0 = PWAW-C-load-int "-2147483648" :li
	--assert -2147483648 = li   
	
	--test-- "li-6"                      ;; to document what happens
	  li: 0 
	--assert 1 = PWAW-C-load-int "2147483648" :li
	--assert 0 = li
	
	--test-- "li-7"                      ;; to document what happens
	  li: 0 
	--assert 1 = PWAW-C-load-int "-2147483649" :li
	--assert 0 = li
	
	--test-- "li-8"
		li: 999
	--assert 1 = PWAW-C-load-int "-" :li
 	
	--test-- "li-9"
	  li: 0 
	--assert 0 = PWAW-C-load-int "+1" :li
	--assert 1 = li
	
	--test-- "li-10"
		li: 0
	--assert 1 = PWAW-C-load-int "abcde" :li
	
~~~end-file~~~

