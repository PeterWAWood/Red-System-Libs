Red/System [
	Title:   "Red/System core library - mold-date test script"
	Author:  "Peter W A Wood"
	File: 	 %mold-date-test.reds
	Rights:  "Copyright (C) 2012 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test/quick-test.reds
#include %../date-time.reds

~~~start-file~~~ "mold-date"
    
	--test-- "md-1"
	  md: "abcdefghijklmnopqrstuvwxy"
	  d: declare PWAW-DT-date!
	  d/year:                 2012
	  d/month:                1
	  d/day:                  13
	  d/hour:                 16
	  d/minutes:              46
	  d/seconds:              27
	  d/microseconds:         511963
	  d/tz-hours:             8
	  d/tz-minutes:           0
	--assert 1 = PWAW-DT-mold-date d md
	--assert PWAW-C-compare-strings "abcdefghijklmnopqrstuvwxy" md
	
	--test-- "md-2"
	  md: "abcdefghijklmnopqrstuvwxyz"
	  d: declare PWAW-DT-date!
	  d/year:               2012
	  d/month:              1
	  d/day:                13
	  d/hour:               16
	  d/minutes:            46
	  d/seconds:            27
	  d/microseconds:       511963
	  d/tz-hours:           8
	  d/tz-minutes:         0
	--assert 0 = PWAW-DT-mold-date d md
	--assert PWAW-C-compare-strings "13-Jan-2012/16:46:27+8:00" md
	
	--test-- "md-3"
	  md: "abcdefghijklmnopqrstuvwxyz"
	  d: declare PWAW-DT-date!
	  d/year:               2012
	  d/month:              1
	  d/day:                1
	  d/hour:               16
	  d/minutes:            46
	  d/seconds:            27
	  d/microseconds:       511963
	  d/tz-hours:           8
	  d/tz-minutes:         0
	--assert 0 = PWAW-DT-mold-date d md
	--assert PWAW-C-compare-strings "1-Jan-2012/16:46:27+8:00" md
	
	--test-- "md-4"
	  md: "abcdefghijklmnopqrstuvwxyz"
	  d: declare PWAW-DT-date!
	  d/year:               2012
	  d/month:              1
	  d/day:                1
	  d/hour:               8
	  d/minutes:            46
	  d/seconds:            27
	  d/microseconds:       511963
	  d/tz-hours:           8
	  d/tz-minutes:         0
	--assert 0 = PWAW-DT-mold-date d md
	--assert PWAW-C-compare-strings "1-Jan-2012/08:46:27+8:00" md
	
	--test-- "md-5"
	  md: "abcdefghijklmnopqrstuvwxyz"
	  d: declare PWAW-DT-date!
	  d/year:               2012
	  d/month:              1
	  d/day:                1
	  d/hour:               8
	  d/minutes:            6
	  d/seconds:            07
	  d/microseconds:       511963
	  d/tz-hours:           8
	  d/tz-minutes:         0
	--assert 0 = PWAW-DT-mold-date d md
	--assert PWAW-C-compare-strings "1-Jan-2012/08:06:07+8:00" md
	
	--test-- "md-6"
	  md: "abcdefghijklmnopqrstuvwxyz"
	  d: declare PWAW-DT-date!
	  d/year:               2012
	  d/month:              1
	  d/day:                1
	  d/hour:               8
	  d/minutes:            46
	  d/seconds:            27
	  d/microseconds:       511963
	  d/tz-hours:           -5
	  d/tz-minutes:         0
	--assert 0 = PWAW-DT-mold-date d md
	--assert PWAW-C-compare-strings "1-Jan-2012/08:46:27-5:00" md
	
	--test-- "md-7"
	  md: "abcdefghijklmnopqrstuvwxyz"
	  d: declare PWAW-DT-date!
	  d/year:               2012
	  d/month:              1
	  d/day:                1
	  d/hour:               8
	  d/minutes:            46
	  d/seconds:            27
	  d/microseconds:       511963
	  d/tz-hours:           -12
	  d/tz-minutes:         0
	--assert 0 = PWAW-DT-mold-date d md
	--assert PWAW-C-compare-strings "1-Jan-2012/08:46:27-12:00" md
	
	--test-- "md-8"
	  md: "abcdefghijklmnopqrstuvwxyz"
	  d: declare PWAW-DT-date!
	  d/year:               2012
	  d/month:              1
	  d/day:                1
	  d/hour:               8
	  d/minutes:            46
	  d/seconds:            27
	  d/microseconds:       511963
	  d/tz-hours:           18
	  d/tz-minutes:         0
	--assert 0 = PWAW-DT-mold-date d md
	--assert PWAW-C-compare-strings "1-Jan-2012/08:46:27+18:00" md
			
~~~end-file~~~

