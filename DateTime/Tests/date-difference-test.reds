Red/System [
	Title:   "Red/System date-time library - date-difference test script"
	Author:  "Peter W A Wood"
	File: 	 %date-difference-test.reds
	Rights:  "Copyright (C) 2012 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../date-time.reds

~~~start-file~~~ "date-difference"

	dd-date1: declare PWAW-DT-date!
	dd-date2: declare PWAW-DT-date!
	dd-time:  declare PWAW-DT-time!
	
	--test-- "dd-1"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date2
	--assert 0 = PWAW-DT-date-difference dd-date1 dd-date2 dd-time
	--assert 0 = dd-time/hours
	--assert 0 = dd-time/minutes
	--assert 0 = dd-time/seconds
	--assert 0 = dd-time/milliseconds
	
	--test-- "dd-2"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:28+08:30" dd-date2
	--assert 0 = PWAW-DT-date-difference dd-date1 dd-date2 dd-time
	--assert 0 = dd-time/hours
	--assert 0 = dd-time/minutes
	--assert 1 = dd-time/seconds
	--assert 0 = dd-time/milliseconds
	
	
	--test-- "dd-3"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:26+08:30" dd-date2
	--assert 0 = PWAW-DT-date-difference dd-date1 dd-date2 dd-time
	--assert 0 = dd-time/hours
	--assert 0 = dd-time/minutes
	--assert 1 = dd-time/seconds
	--assert 0 = dd-time/milliseconds
	
	--test-- "dd-4"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date1
		dd-r: PWAW-DT-load-date "13-Jan-2012/15:46:27+08:30" dd-date2
	--assert 0 = PWAW-DT-date-difference dd-date1 dd-date2 dd-time
	--assert 1 = dd-time/hours
	--assert 0 = dd-time/minutes
	--assert 0 = dd-time/seconds
	--assert 0 = dd-time/milliseconds
	
~~~end-file~~~

