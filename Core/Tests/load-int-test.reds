Red/System [
	Title:   "Red/System core library - str-int? test script"
	Author:  "Peter W A Wood"
	File: 	 %load-int-test.reds
	Rights:  "Copyright (C) 2012 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test/quick-test.reds
#include %../core.reds

~~~start-file~~~ "load-int"
    
    si: declare struct! [
	    li  [integer!]
	  ]

	--test-- "li-1"
	  si/li: 0
	--assert 0 = PWAW-C-load-int ["1" as pointer! [integer!] si]
	--assert 1 = si/li
	
	--test-- "li-2"
	  si/li: 999
	--assert 0 = PWAW-C-load-int ["0" as pointer! [integer!] si]
	--assert 0 = si/li
	
	--test-- "li-3"
	  si/li: 0 
	--assert 0 = PWAW-C-load-int ["-1" as pointer! [integer!] si]
	--assert -1 = si/li
	
	--test-- "li-4"
	  si/li: 0 
	--assert 0 = PWAW-C-load-int ["2147483647" as pointer! [integer!] si]
	--assert 2147483647 = si/li
	
	--test-- "li-5"
	  si/li: 0 
	--assert 0 = PWAW-C-load-int ["-2147483648" as pointer! [integer!] si]
	--assert -2147483648 = si/li   
	
	--test-- "li-6"                      ;; to document what happens
	  si/li: 0 
	--assert 0 = PWAW-C-load-int ["2147483648" as pointer! [integer!] si]
	--assert -2147483648 = si/li
	
	--test-- "li-7"                      ;; to document what happens
	  si/li: 0 
	--assert 0 = PWAW-C-load-int ["-2147483649" as pointer! [integer!] si]
	--assert 2147483647 = si/li
	
	--test-- "li-8"
	  si/li: 0
	--assert 0 = PWAW-C-load-int ["a1c" as pointer! [integer!] si 2 2]
	--assert 1 = si/li
	
	--test-- "li-9"
	  si/li: 999
	--assert 0 = PWAW-C-load-int ["abcde0fg" as pointer! [integer!] si 6 6]
	--assert 0 = si/li

	--test-- "li-10"
	  si/li: 0 
	--assert 0 = PWAW-C-load-int ["abcde-10" as pointer! [integer!] si 6 8]
	--assert -10 = si/li
	
	--test-- "li-11"
	  si/li: 999
	--assert 8 = PWAW-C-load-int ["-" as pointer! [integer!] si]
	
	--test-- "li-12"
	  si/li: 0 
	--assert 0 = PWAW-C-load-int ["+1" as pointer! [integer!] si]
	--assert 1 = si/li
	
~~~end-file~~~

