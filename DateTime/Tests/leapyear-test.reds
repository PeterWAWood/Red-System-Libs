Red/System [
	Title:   "Red/System DateTime library - leapyear? test script"
	Author:  "Peter W A Wood"
	Rights:  "Copyright (C) 2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-DT-date-time.reds

~~~start-file~~~ "leap-year?"
    
	--test-- "ly-1"
	--assert not PWAW-DT-leapyear? 1
	
	--test-- "ly-2"
	--assert PWAW-DT-leapyear? 4
	
	--test-- "ly-3"
	--assert not PWAW-DT-leapyear? 5
	
	--test-- "ly-4"
	--assert PWAW-DT-leapyear? 1996
	
	--test-- "ly-5"
	--assert not PWAW-DT-leapyear? 1900
	
	--test-- "ly-6"
	--assert PWAW-DT-leapyear? 2000
	
	--test-- "ly-7"
	--assert PWAW-DT-leapyear? 2004

	~~~end-file~~~

