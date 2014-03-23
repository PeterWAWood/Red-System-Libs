Red/System [
  Purpose:     "LibC module for date-time library"
  Author:      "Peter W A Wood"
  Version:     0.2.0
  Rights:      "Copyright © 2011 - 2014 Peter W A Wood. All rights reserved."
  License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

PWAW-DT-timeval!: alias struct! [
  seconds           [integer!]            
  microseconds      [integer!]
]

PWAW-DT-tm!: alias struct! [
  sec       [integer!]
  min       [integer!]
  hour      [integer!]
  mday      [integer!]
  mon       [integer!]
  year      [integer!]
  wday      [integer!]
  yday      [integer!]
  isdst     [integer!]
  gmtoff    [integer!]
  zone      [c-string!]
]

#import [
	LIBC-FILE cdecl [
		PWAW-DT-as-localtime: "localtime_r" [
			time        [pointer! [integer!]]
			result      [PWAW-DT-tm!]
			return:     [PWAW-DT-tm!]
		]
		PWAW-DT-get-time-of-day: "gettimeofday" [
			time-of-day [PWAW-DT-timeval!]
			timezone    [struct! [
				mins    [integer!]
				dst     [integer!]
			]]
			return:     [integer!]
		]
	]
]

PWAW-DT-now: func [
  {provides the current date/time}
  result      [PWAW-DT-date!]
  {An initialised PWAW-DT-date! struct for the date/time}
  return:     [integer!]
  {    0 - successful
       1 - cannot retrieve time from os
       2 - cannot convert the machine time
       3 - cannot retrieve time zone
  }
  /local
  errcode		[integer!]
  tz			[struct! [
    mins        [integer!] 
    dst         [integer!]
  ]]
  time			[integer!]
  tm			[PWAW-DT-tm!]
][
  
  ;; local variables
  localtime: declare PWAW-DT-timeval!
  tz: declare struct! [
    mins      [integer!]
    dst       [integer!]
  ]
  tm: declare PWAW-DT-tm!
  
  ;; get the machine time
  if 0 <> PWAW-DT-get-time-of-day localtime tz [
    return 1
  ]
  time: localtime/seconds
  
  ;; expand the time into date & time info
  if null = PWAW-DT-as-localtime :time tm [return 2]
  
  ;; fill the date structure
  result/year:              tm/year + 1900
  result/month:             tm/mon + 1
  result/day:               tm/mday
  result/hour:              tm/hour
  result/minutes:           tm/min
  result/seconds:           tm/sec
  result/microseconds:      localtime/microseconds
  result/tz-hours:          tz/mins / 60
  result/tz-minutes:        tz/mins % 60
  
  ;; successful return
  0
]
 
