Red/System [
	Title:   "Red/System byte! datatype test script"
	Author:  "Peter W A Wood"
	File: 	 %byte-test.reds
	Rights:  "Copyright (C) 2011 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test/quick-test.reds
#include %../date-time.reds

~~~start-file~~~ "difference"

    tv-start: declare PWAW-DT-timeval!
    tv-end: declare PWAW-DT-timeval!
    tv-result: declare PWAW-DT-timeval!

	--test-- "tv-1"
	  tv-end/seconds: 0
	  tv-end/microseconds: 0
	  tv-start/seconds: 0
	  tv-start/microseconds: 0
	--assert 0 = PWAW-DT-difference tv-end tv-start tv-result
	--assert 0 = tv-result/seconds
	--assert 0 = tv-result/microseconds
	
	--test-- "tv-2"
	  tv-end/seconds: 0
	  tv-end/microseconds: 1
	  tv-start/seconds: 0
	  tv-start/microseconds: 0
	--assert 0 = PWAW-DT-difference tv-end tv-start tv-result
	--assert 0 = tv-result/seconds
	--assert 1 = tv-result/microseconds
	
	--test-- "tv-3"
	  tv-end/seconds: 0
	  tv-end/microseconds: 0
	  tv-start/seconds: 0
	  tv-start/microseconds: 1
	--assert 1 = PWAW-DT-difference tv-end tv-start tv-result
	--assert -1 = tv-result/seconds
	--assert 999999 = tv-result/microseconds
	
	--test-- "tv-4"
	  tv-end/seconds: 128
	  tv-end/microseconds: 256
	  tv-start/seconds: 1
	  tv-start/microseconds: 1
	--assert 0 = PWAW-DT-difference tv-end tv-start tv-result
	--assert 127 = tv-result/seconds
	--assert 255 = tv-result/microseconds

~~~end-file~~~

