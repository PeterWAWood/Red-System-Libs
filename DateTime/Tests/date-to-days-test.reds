Red/System [
	Title:   "Red/System core library - date-to-days test script"
	Author:  "Peter W A Wood"
	Rights:  "Copyright (C) 2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-DT-date-time.reds

~~~start-file~~~ "date-to-days"
    
	--test-- "dtd-1"
		i: 0
	 	d: declare PWAW-DT-date!
	 	d/year:                 1
	 	d/month:                1
		d/day:                  1
		d/hour:                 0
		d/minutes:              0
		d/seconds:              0
		d/microseconds:         0
		d/tz-hours:             0
		d/tz-minutes:           0
	--assert 0 = PWAW-DT-date-to-days d :i
	--assert 1 = i
	
	--test-- "dtd-2"
		i: 0
	 	d: declare PWAW-DT-date!
	 	d/year:                 1
	 	d/month:                1
		d/day:                  31
		d/hour:                 0
		d/minutes:              0
		d/seconds:              0
		d/microseconds:         0
		d/tz-hours:             0
		d/tz-minutes:           0
	--assert 0 = PWAW-DT-date-to-days d :i
	--assert 31 = i
	
	--test-- "dtd-3"
		i: 0
	 	d: declare PWAW-DT-date!
	 	d/year:                 1
	 	d/month:                2
		d/day:                  1
		d/hour:                 0
		d/minutes:              0
		d/seconds:              0
		d/microseconds:         0
		d/tz-hours:             0
		d/tz-minutes:           0
	--assert 0 = PWAW-DT-date-to-days d :i
	--assert 32 = i
	
	--test-- "dtd-4"
		i: 0
	 	d: declare PWAW-DT-date!
	 	d/year:                 1
	 	d/month:                11
		d/day:                  10
		d/hour:                 0
		d/minutes:              0
		d/seconds:              0
		d/microseconds:         0
		d/tz-hours:             0
		d/tz-minutes:           0
	--assert 0 = PWAW-DT-date-to-days d :i
	--assert 314 = i
	
	--test-- "dtd-5"
		i: 0
	 	d: declare PWAW-DT-date!
	 	d/year:                 4
	 	d/month:                11
		d/day:                  10
		d/hour:                 0
		d/minutes:              0
		d/seconds:              0
		d/microseconds:         0
		d/tz-hours:             0
		d/tz-minutes:           0
	--assert 0 = PWAW-DT-date-to-days d :i
	--assert 1410 = i
	
	--test-- "dtd-6"
		i: 0
	 	d: declare PWAW-DT-date!
	 	d/year:                 5
	 	d/month:                11
		d/day:                  10
		d/hour:                 0
		d/minutes:              0
		d/seconds:              0
		d/microseconds:         0
		d/tz-hours:             0
		d/tz-minutes:           0
	--assert 0 = PWAW-DT-date-to-days d :i
	--assert 1775 = i
	
	--test-- "dtd-7"
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
	--assert 0 = PWAW-DT-date-to-days d :i
	--assert 735579 = i
	
	--test-- "dtd-8"
		i: 0
	 	d: declare PWAW-DT-date!
	 	d/year:                 2015
	 	d/month:                12
		d/day:                  16
		d/hour:                 0
		d/minutes:              0
		d/seconds:              0
		d/microseconds:         0
		d/tz-hours:             0
		d/tz-minutes:           0
	--assert 0 = PWAW-DT-date-to-days d :i
	--assert 735945 = i
	
	--test-- "dtd-9"
		i: 0
	 	d: declare PWAW-DT-date!
	 	d/year:                 2012
	 	d/month:                1
		d/day:                  13
		d/hour:                 0
		d/minutes:              0
		d/seconds:              0
		d/microseconds:         0
		d/tz-hours:             0
		d/tz-minutes:           0
	--assert 0 = PWAW-DT-date-to-days d :i
	--assert 734512 = i
	
	--test-- "dtd-10"
		i: 0
	 	d: declare PWAW-DT-date!
	 	d/year:                 2012
	 	d/month:                1
		d/day:                  14
		d/hour:                 0
		d/minutes:              0
		d/seconds:              0
		d/microseconds:         0
		d/tz-hours:             0
		d/tz-minutes:           0
	--assert 0 = PWAW-DT-date-to-days d :i
	--assert 734513 = i
	
	--test-- "dtd-11"
		i: 0
	 	d: declare PWAW-DT-date!
	 	d/year:                 2013
	 	d/month:                1
		d/day:                  14
		d/hour:                 0
		d/minutes:              0
		d/seconds:              0
		d/microseconds:         0
		d/tz-hours:             0
		d/tz-minutes:           0
	--assert 0 = PWAW-DT-date-to-days d :i
	--assert 734879 = i
	
	
~~~end-file~~~

