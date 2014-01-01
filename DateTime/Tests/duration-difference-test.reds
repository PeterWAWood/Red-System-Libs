Red/System [
	Title:   "Red/System date-time library - duration-difference test script"
	Author:  "Peter W A Wood"
	File: 	 %date-difference-test.reds
	Rights:  "Copyright (C) 2014 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-DT-date-time.reds

~~~start-file~~~ "duration-difference"
		dd-dur1: declare PWAW-DT-duration!
		dd-dur2: declare PWAW-DT-duration!
		dd-dur:  declare PWAW-DT-duration!
		init: does [
			PWAW-DT-ZERO-DURATION(dd-dur1)	
			PWAW-DT-ZERO-DURATION(dd-dur2)
			PWAW-DT-ZERO-DURATION(dd-dur)
		]
	
	--test-- "dd-1"
		init
	--assert 0 = PWAW-DT-duration-difference dd-dur1 dd-dur2 dd-dur
	--assert 0 = dd-dur/days
	--assert 0 = dd-dur/hours
	--assert 0 = dd-dur/minutes
	--assert 0 = dd-dur/seconds
	--assert 0 = dd-dur/microseconds
	
	--test-- "dd-2"
		init
		dd-dur1/days: 1
		dd-dur2/hours: 1
	--assert 0 = PWAW-DT-duration-difference dd-dur1 dd-dur2 dd-dur
	--assert 0 = dd-dur/days
	--assert 23 = dd-dur/hours
	--assert 0 = dd-dur/minutes
	--assert 0 = dd-dur/seconds
	--assert 0 = dd-dur/microseconds
	
	--test-- "dd-3"
		init
		dd-dur1/days: 1
		dd-dur1/hours: 1
		dd-dur1/minutes: 1
		dd-dur1/seconds: 1
		dd-dur1/microseconds: 1
		dd-dur2/days: 0
		dd-dur2/hours: 2
		dd-dur2/minutes: 2
		dd-dur2/seconds: 2
		dd-dur2/microseconds: 2
	--assert 0 = PWAW-DT-duration-difference dd-dur1 dd-dur2 dd-dur
	--assert 0 = dd-dur/days
	--assert 22 = dd-dur/hours
	--assert 58 = dd-dur/minutes
	--assert 58 = dd-dur/seconds
	--assert 999 = dd-dur/microseconds
	
~~~end-file~~~

