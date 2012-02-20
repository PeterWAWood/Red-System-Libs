Red/System [
	Title:   "Red/System date-time library - timer test script"
	Author:  "Peter W A Wood"
	File: 	 %timer-test.reds
	Rights:  "Copyright (C) 2011 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test/quick-test.reds
#include %../date-time.reds

~~~start-file~~~ "timer"

    start: declare PWAW-DT-cpu-ticks!
    time: declare PWAW-DT-cpu-ticks!
    
	--test-- "timer-1"
	  start/ticks: 0
	  time/ticks: 0
	--assert 0 = PWAW-DT-timer 1 start time
	--assert start/ticks > -1
	
	--test-- "timer-2"
	  start/ticks: 0
	  time/ticks: 0
	  PWAW-DT-timer 1 start time
	  save-time: start/ticks
	  t2-i: 10000000
	  until [
	    t2-i: t2-i - 1
	    t2-i = 0
	  ]
	  time/ticks: 0
	--assert 0 = PWAW-DT-timer 2 start time
	--assert start/ticks = save-time
	--assert time/ticks > 0

	--test-- "timer-3"
	  start/ticks: 0
	  time/ticks: 0
	  PWAW-DT-start-timer start time
	  t2-i: 10000000
	  until [
	    t2-i: t2-i - 1
	    t2-i = 0
	  ]
	  time/ticks: 0
	--assert 0 = PWAW-DT-time-taken start time
	--assert time/ticks > 0
	
~~~end-file~~~

