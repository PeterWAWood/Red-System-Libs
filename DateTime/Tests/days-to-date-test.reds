Red/System [
	Title:   "Red/System core library - date-to-days test script"
	Author:  "Peter W A Wood"
	Rights:  "Copyright (C) 2013 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test.reds
#include %../PWAW-DT-date-time.reds

~~~start-file~~~ "days-to-date"
    
	--test-- "dtd-1"
	 	d: declare PWAW-DT-date!
	 	PWAW-DT-ZERO-DATE(d)
	--assert 0 = PWAW-DT-days-to-date 1 d
	--assert d/year = 1
	--assert d/month = 1
	--assert d/day = 1
	--assert d/hour = 0
	--assert d/minutes = 0
	--assert d/seconds = 0
	--assert d/microseconds = 0
	--assert d/tz-hours = 0
	--assert d/tz-minutes = 0
	
	--test-- "dtd-2"
	 	d: declare PWAW-DT-date!
	 	PWAW-DT-ZERO-DATE(d)

	--assert 0 = PWAW-DT-days-to-date 31 d
	--assert d/year = 1
	--assert d/month = 1
	--assert d/day = 31
	--assert d/hour = 0
	--assert d/minutes = 0
	--assert d/seconds = 0
	--assert d/microseconds = 0
	--assert d/tz-hours = 0
	--assert d/tz-minutes = 0
	
	--test-- "dtd-3"
	 	d: declare PWAW-DT-date!
	 	PWAW-DT-ZERO-DATE(d)
	--assert 0 = PWAW-DT-days-to-date 32 d
	--assert d/year = 1
	--assert d/month = 2
	--assert d/day = 1
	--assert d/hour = 0
	--assert d/minutes = 0
	--assert d/seconds = 0
	--assert d/microseconds = 0
	--assert d/tz-hours = 0
	--assert d/tz-minutes = 0
	
	--test-- "dtd-4"
	 	d: declare PWAW-DT-date!
	 	PWAW-DT-ZERO-DATE(d)
	--assert 0 = PWAW-DT-days-to-date 314 d
	--assert d/year = 1
	--assert d/month = 11
	--assert d/day = 10
	--assert d/hour = 0
	--assert d/minutes = 0
	--assert d/seconds = 0
	--assert d/microseconds = 0
	--assert d/tz-hours = 0
	--assert d/tz-minutes = 0
	
	--test-- "dtd-5"
	 	d: declare PWAW-DT-date!
	 	PWAW-DT-ZERO-DATE(d)
	--assert 0 = PWAW-DT-days-to-date 1409 d
	--assert d/year = 4
	--assert d/month = 11
	--assert d/day = 9
	--assert d/hour = 0
	--assert d/minutes = 0
	--assert d/seconds = 0
	--assert d/microseconds = 0
	--assert d/tz-hours = 0
	--assert d/tz-minutes = 0
	
	--test-- "dtd-6"
	 	d: declare PWAW-DT-date!
	 	PWAW-DT-ZERO-DATE(d)
	--assert 0 = PWAW-DT-days-to-date 1775 d
	--assert d/year = 5
	--assert d/month = 11
	--assert d/day = 10
	--assert d/hour = 0
	--assert d/minutes = 0
	--assert d/seconds = 0
	--assert d/microseconds = 0
	--assert d/tz-hours = 0
	--assert d/tz-minutes = 0
	
	--test-- "dtd-7"
	 	d: declare PWAW-DT-date!
	 	PWAW-DT-ZERO-DATE(d)
	--assert 0 = PWAW-DT-days-to-date 735231 d
	--assert d/year = 2014
	--assert d/month = 1
	--assert d/day = 1
	--assert d/hour = 0
	--assert d/minutes = 0
	--assert d/seconds = 0
	--assert d/microseconds = 0
	--assert d/tz-hours = 0
	--assert d/tz-minutes = 0
	
	--test-- "dtd-8"
	 	d: declare PWAW-DT-date!
	 	PWAW-DT-ZERO-DATE(d)
	--assert 0 = PWAW-DT-days-to-date 735579 d
	--assert d/year = 2014
	--assert d/month = 12
	--assert d/day = 15
	--assert d/hour = 0
	--assert d/minutes = 0
	--assert d/seconds = 0
	--assert d/microseconds = 0
	--assert d/tz-hours = 0
	--assert d/tz-minutes = 0
	
	--test-- "dtd-9"
	 	d: declare PWAW-DT-date!
	 	PWAW-DT-ZERO-DATE(d)
	--assert 0 = PWAW-DT-days-to-date 735945 d
	--assert d/year = 2015
	--assert d/month = 12
	--assert d/day = 16
	--assert d/hour = 0
	--assert d/minutes = 0
	--assert d/seconds = 0
	--assert d/microseconds = 0
	--assert d/tz-hours = 0
	--assert d/tz-minutes = 0
	
	--test-- "dtd-10"
	 	d: declare PWAW-DT-date!
	 	PWAW-DT-ZERO-DATE(d)
	--assert 0 = PWAW-DT-days-to-date 734512 d
	--assert d/year = 2012
	--assert d/month = 1
	--assert d/day = 13
	--assert d/hour = 0
	--assert d/minutes = 0
	--assert d/seconds = 0
	--assert d/microseconds = 0
	--assert d/tz-hours = 0
	--assert d/tz-minutes = 0
	
	--test-- "dtd-11"
	 	d: declare PWAW-DT-date!
	 	PWAW-DT-ZERO-DATE(d)
	--assert 0 = PWAW-DT-days-to-date 734513 d
	--assert d/year = 2012
	--assert d/month = 1
	--assert d/day = 14
	--assert d/hour = 0
	--assert d/minutes = 0
	--assert d/seconds = 0
	--assert d/microseconds = 0
	--assert d/tz-hours = 0
	--assert d/tz-minutes = 0
	
	--test-- "dtd-12"
	 	d: declare PWAW-DT-date!
	 	PWAW-DT-ZERO-DATE(d)
	--assert 0 = PWAW-DT-days-to-date 734879 d
	--assert d/year = 2013
	--assert d/month = 1
	--assert d/day = 14
	--assert d/hour = 0
	--assert d/minutes = 0
	--assert d/seconds = 0
	--assert d/microseconds = 0
	--assert d/tz-hours = 0
	--assert d/tz-minutes = 0
	
~~~end-file~~~

