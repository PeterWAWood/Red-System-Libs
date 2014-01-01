Red/System [
	Title:   "Red/System core library - days-in-year test script"
	Author:  "Peter W A Wood"
	Rights:  "Copyright (C) 2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-DT-date-time.reds

~~~start-file~~~ "date-to-days"
    
	--test-- "diy-1"
		i: 0
	 	d: declare PWAW-DT-date!
	 	d/year:                 0
	 	d/month:                1
		d/day:                  1
		d/hour:                 0
		d/minutes:              0
		d/seconds:              0
		d/microseconds:         0
		d/tz-hours:             0
		d/tz-minutes:           0
	--assert 0 = PWAW-DT-days-in-year-todate d :i
	--assert 0 = i
	
	--test-- "diy-2"
		i: 0
	 	d: declare PWAW-DT-date!
	 	d/year:                 0
	 	d/month:                1
		d/day:                  31
		d/hour:                 0
		d/minutes:              0
		d/seconds:              0
		d/microseconds:         0
		d/tz-hours:             0
		d/tz-minutes:           0
	--assert 0 = PWAW-DT-days-in-year-todate d :i
	--assert 30 = i
	
	--test-- "diy-3"
		i: 0
	 	d: declare PWAW-DT-date!
	 	d/year:                 0
	 	d/month:                2
		d/day:                  1
		d/hour:                 0
		d/minutes:              0
		d/seconds:              0
		d/microseconds:         0
		d/tz-hours:             0
		d/tz-minutes:           0
	--assert 0 = PWAW-DT-days-in-year-todate d :i
	--assert 31 = i
	
	--test-- "diy-4"
		i: 0
	 	d: declare PWAW-DT-date!
	 	d/year:                 2000
	 	d/month:                3
		d/day:                  1
		d/hour:                 0
		d/minutes:              0
		d/seconds:              0
		d/microseconds:         0
		d/tz-hours:             0
		d/tz-minutes:           0
	--assert 0 = PWAW-DT-days-in-year-todate d :i
	--assert 60 = i
	
	--test-- "diy-5"
		i: 0
	 	d: declare PWAW-DT-date!
	 	d/year:                 1996
	 	d/month:                3
		d/day:                  1
		d/hour:                 0
		d/minutes:              0
		d/seconds:              0
		d/microseconds:         0
		d/tz-hours:             0
		d/tz-minutes:           0
	--assert 0 = PWAW-DT-days-in-year-todate d :i
	--assert 60 = i
	
	--test-- "diy-5"
		i: 0
	 	d: declare PWAW-DT-date!
	 	d/year:                 1900
	 	d/month:                3
		d/day:                  1
		d/hour:                 0
		d/minutes:              0
		d/seconds:              0
		d/microseconds:         0
		d/tz-hours:             0
		d/tz-minutes:           0
	--assert 0 = PWAW-DT-days-in-year-todate d :i
	--assert 59 = i
	
	--test-- "diy-6"
		i: 0
	 	d: declare PWAW-DT-date!
	 	d/year:                 2014
	 	d/month:                12
		d/day:                  15
		d/hour:                 0
		d/minutes:              0
		d/seconds:              0
		d/microseconds:         0
		d/tz-hours:             0
		d/tz-minutes:           0
	--assert 0 = PWAW-DT-days-in-year-todate d :i
	--assert 348 = i
	
~~~end-file~~~

