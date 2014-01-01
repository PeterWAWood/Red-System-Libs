Red/System [
	Title:   "Red/System date-time library - date-difference test script"
	Author:  "Peter W A Wood"
	File: 	 %date-difference-test.reds
	Rights:  "Copyright (C) 2012-2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-DT-date-time.reds

~~~start-file~~~ "date-difference"

	dd-date1: declare PWAW-DT-date!
	dd-date2: declare PWAW-DT-date!
	dd-dur:   declare PWAW-DT-duration!
	
	--test-- "dd-1"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date2
	--assert 0 = PWAW-DT-date-difference dd-date1 dd-date2 dd-dur
	--assert 0 = dd-dur/days
	--assert 0 = dd-dur/hours
	--assert 0 = dd-dur/minutes
	--assert 0 = dd-dur/seconds
	--assert 0 = dd-dur/microseconds
	
	--test-- "dd-2"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:28+08:30" dd-date2
	--assert 0 = PWAW-DT-date-difference dd-date1 dd-date2 dd-dur
	--assert 0 = dd-dur/days
	--assert 0 = dd-dur/hours
	--assert 0 = dd-dur/minutes
	--assert 1 = dd-dur/seconds
	--assert 0 = dd-dur/microseconds
	
	
	--test-- "dd-3"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:26+08:30" dd-date2
	--assert 0 = PWAW-DT-date-difference dd-date1 dd-date2 dd-dur
	--assert 0 = dd-dur/days
	--assert 0 = dd-dur/hours
	--assert 0 = dd-dur/minutes
	--assert 1 = dd-dur/seconds
	--assert 0 = dd-dur/microseconds
	
	--test-- "dd-4"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "13-Jan-2012/15:46:27+08:30" dd-date2
	--assert 0 = PWAW-DT-date-difference dd-date1 dd-date2 dd-dur
	--assert 0 = dd-dur/days
	--assert 1 = dd-dur/hours
	--assert 0 = dd-dur/minutes
	--assert 0 = dd-dur/seconds
	--assert 0 = dd-dur/microseconds
	
	--test-- "dd-5"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "12-Jan-2012/15:45:26+08:30" dd-date2
	--assert 0 = PWAW-DT-date-difference dd-date1 dd-date2 dd-dur
	--assert 1 = dd-dur/days
	--assert 1 = dd-dur/hours
	--assert 1 = dd-dur/minutes
	--assert 1 = dd-dur/seconds
	--assert 0 = dd-dur/microseconds
	
	--test-- "dd-6"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+09:30" dd-date2
	--assert 0 = PWAW-DT-date-difference dd-date1 dd-date2 dd-dur
	--assert 0 = dd-dur/days
	--assert 1 = dd-dur/hours
	--assert 0 = dd-dur/minutes
	--assert 0 = dd-dur/seconds
	--assert 0 = dd-dur/microseconds
	
	--test-- "dd-7"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:15" dd-date2
	--assert 0 = PWAW-DT-date-difference dd-date1 dd-date2 dd-dur
	--assert 0 = dd-dur/days
	--assert 0 = dd-dur/hours
	--assert 15 = dd-dur/minutes
	--assert 0 = dd-dur/seconds
	--assert 0 = dd-dur/microseconds
	
~~~end-file~~~

