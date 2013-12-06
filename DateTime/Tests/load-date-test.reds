Red/System [
	Title:   "Red/System core library - load-date test script"
	Author:  "Peter W A Wood"
	File: 	 %load-date-test.reds
	Rights:  "Copyright (C) 2012 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-DT-date-time.reds

~~~start-file~~~ "load-date"
    
	--test-- "ld-1"
		d: declare PWAW-DT-date!
		r: PWAW-DT-load-date "13-Jan-2012/16:46:27+08:30" d
	--assert r =               0
	--assert d/year =          2012
	--assert d/month =         1
	--assert d/day =           13
	--assert d/hour =          16
	--assert d/minutes =       46
	--assert d/seconds =       27
	--assert d/microseconds =  0
	--assert d/tz-hours =      8
	--assert d/tz-minutes =    30
	md: "abcdefghijklmnopqrstuvwxy"
	
	--test-- "ld-2"
		d: declare PWAW-DT-date!
		r: PWAW-DT-load-date "31-Jan-1997/16:46:27-08:00" d
	--assert r =               0
	;--assert d/year =          1997
	;--assert d/month =         1
	;--assert d/day =           31
	;--assert d/hour =          16
	;--assert d/minutes =       46
	;--assert d/seconds =       27
	;--assert d/microseconds =  0
	;--assert d/tz-hours =      -8
	;--assert d/tz-minutes =    0
	
	--test-- "ld-3"
	  d: declare PWAW-DT-date!
	--assert 1 = PWAW-DT-load-date "32-Jan-1997/16:46:27-08:00" d
	
	--test-- "ld-4"
	  d: declare PWAW-DT-date!
	--assert 1 = PWAW-DT-load-date "00-Jan-1997/16:46:27-08:00" d
	
	--test-- "ld-5"
	  d: declare PWAW-DT-date!
	--assert 1 = PWAW-DT-load-date "aa-Jan-1997/16:46:27-08:00" d
	
	--test-- "ld-6"
	  d: declare PWAW-DT-date!
	--assert 2 = PWAW-DT-load-date "31-Jon-1997/16:46:27-08:00" d
	
	--test-- "ld-7"
	  d: declare PWAW-DT-date!
	--assert 3 = PWAW-DT-load-date "31-Jan--997/16:46:27-08:00" d
	
	--test-- "ld-8"
	  d: declare PWAW-DT-date!
	--assert 7 = PWAW-DT-load-date "31-Jan-1997/16:46:27-08:01" d
	
	--test-- "ld-9"
	  d: declare PWAW-DT-date!
	--assert 7 = PWAW-DT-load-date "31-Jan-1997/16:46:27+19:00" d
	
	--test-- "ld-8"
	  d: declare PWAW-DT-date!
	--assert 8 = PWAW-DT-load-date "29-Feb-1900/16:46:27-08:00" d
	
	--test-- "ld-9"
	  d: declare PWAW-DT-date!
	--assert 0 = PWAW-DT-load-date "29-Feb-2000/16:46:27-08:00" d
	
	--test-- "ld-10"
	  d: declare PWAW-DT-date!
	--assert 0 = PWAW-DT-load-date "29-Feb-2012/16:46:27-08:00" d
	
	--test-- "ld-11"
	  d: declare PWAW-DT-date!
	--assert 8 = PWAW-DT-load-date "29-Feb-2011/16:46:27-08:00" d
	
	--test-- "ld-12"
	  d: declare PWAW-DT-date!
	--assert 8 = PWAW-DT-load-date "31-Apr-2012/16:46:27-08:00" d
	
	--test-- "ld-13"
	  d: declare PWAW-DT-date!
	--assert 0 = PWAW-DT-load-date "31-Jul-2012/16:46:27-08:00" d
			
~~~end-file~~~

