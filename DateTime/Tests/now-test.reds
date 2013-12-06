Red/System [
	Title:   "Red/System date-time library - now test script"
	Author:  "Peter W A Wood"
	File: 	 %now-test.reds
	Rights:  "Copyright (C) 2011 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-DT-date-time.reds

~~~start-file~~~ "now"

    n-now: declare PWAW-DT-date!
    
	--test-- "tv-1"
	--assert 0 = PWAW-DT-now n-now
	--assert n-now/year > 2012
	--assert n-now/month > 0
	--assert n-now/month < 13
	--assert n-now/day > 0
	--assert n-now/day < 32
	--assert n-now/minutes >= 0
	--assert n-now/minutes < 60
	--assert n-now/seconds >= 0
	--assert n-now/seconds <= 60
	--assert n-now/microseconds >= 0 
	--assert n-now/microseconds < 1000000
	--assert n-now/tz-hours > -15
	--assert n-now/tz-hours < 15
	--assert n-now/tz-minutes >= 0
	--assert n-now/tz-minutes < 60
	
~~~end-file~~~

