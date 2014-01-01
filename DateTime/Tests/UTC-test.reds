Red/System [
	Title:   "Red/System date-time library - date-difference test script"
	Author:  "Peter W A Wood"

	Rights:  "Copyright (C) 2012-2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-DT-date-time.reds

~~~start-file~~~ "UTC"

	dd-date: declare PWAW-DT-date!
	dd-UTC: declare PWAW-DT-date!
	
	--test-- "dd-1"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" dd-date
	--assert 0 = PWAW-DT-UTC dd-date dd-UTC
	--assert dd-UTC/year = 2012
	--assert dd-UTC/month = 1
	--assert dd-UTC/day = 13
	--assert dd-UTC/hour = 8
	--assert dd-UTC/minutes = 16
	--assert dd-UTC/seconds = 27
	--assert dd-UTC/microseconds = 0
	
	--test-- "dd-2"
		dd-r: PWAW-DT-load-date "13-Jan-2012/16:16:27+08:30" dd-date
	--assert 0 = PWAW-DT-UTC dd-date dd-UTC
	--assert dd-UTC/year = 2012
	--assert dd-UTC/month = 1
	--assert dd-UTC/day = 13
	--assert dd-UTC/hour = 7
	--assert dd-UTC/minutes = 46
	--assert dd-UTC/seconds = 27
	--assert dd-UTC/microseconds = 0
	
	--test-- "dd-3"
		dd-r: PWAW-DT-load-date "13-Jan-2012/07:46:27+08:30" dd-date
	--assert 0 = PWAW-DT-UTC dd-date dd-UTC
	--assert dd-UTC/year = 2012
	--assert dd-UTC/month = 1
	--assert dd-UTC/day = 12
	--assert dd-UTC/hour = 23
	--assert dd-UTC/minutes = 16
	--assert dd-UTC/seconds = 27
	--assert dd-UTC/microseconds = 0
	
~~~end-file~~~

