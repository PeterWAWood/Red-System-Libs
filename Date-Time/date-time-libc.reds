Red/System [
  Purpose     LibC module for date-time library
  Author      Peter W A Wood
  Version     0.0.1
  Rights      Copyright © 2011 Peter W A Wood. All rights reserved.
  License     BSD-3        
              (https://github.com/dockimbel/Red/blob/master/BSD-3-License.txt)
]

#define PWAW-DT-MICROSECONDS 1000000
 
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

#switch OS [
	Syllable [#define LIBC-file	"libc.so.2"]
	MacOSX	 [#define LIBC-file	"libc.dylib"]
	#default [#define LIBC-file	"libc.so.6"]
]

#import [
	LIBC-file cdecl [
	  get-time-of-day: "gettimeofday" [
	    time-of-day [PWAW-DT-timeval!]
	    timezone    [struct! [
	        mins    [integer!]
	        dst     [integer!]
	    ]]
	    return:     [integer!]
	  ]
	  as-localtime: "localtime_r" [
	    time        [struct! [
	      secs [integer!]
	    ]]
	    result      [PWAW-DT-tm!]
	    return:     [PWAW-DT-tm!]
	  ]
	]
]

PWAW-DT-difference: func [
  end-time          [PWAW-DT-timeval!]
  start-time        [PWAW-DT-timeval!]
  result            [PWAW-DT-timeval!]
  return:           [integer!]
  /local
  errcode           [integer!]
][  
  
  either end-time/microseconds < start-time/microseconds [
    result/seconds: end-time/seconds - start-time/seconds - 1
    result/microseconds: end-time/microseconds - 
                         start-time/microseconds + 
                         PWAW-DT-MICROSECONDS
  ][
    result/seconds: end-time/seconds - start-time/seconds
    result/microseconds: end-time/microseconds - start-time/microseconds
  ]
  
  either result/seconds < 0 [
    errcode: 1
  ][
    errcode: 0
  ]

]

PWAW-DT-now: func [
;; fills the result structure argument with details of the current date/time
;; returns:
;;        0 - successful
;;        1 - cannot retrieve time from os
;;        2 - cannot convert the machine time

  result      [PWAW-DT-date!]
  return:     [integer!]
  /local
  errcode     [integer!]
  tz          [struct! [
    mins        [integer!] 
    dst         [integer!]
  ]]
  time        [struct! [
    secs        [integer!]
  ]]
  tm          [PWAW-DT-tm!]
][
  
  ;; local variables
  localtime: declare PWAW-DT-timeval!
  tz: declare struct! [
    mins      [integer!]
    dst       [integer!]
  ]
  time: declare struct! [
    secs [integer!]
  ]
  tm: declare PWAW-DT-tm!
  
  ;; get the machine time
  if 0 <> get-time-of-day localtime tz [
    return 1
  ]
  time/secs: localtime/seconds
  
  ;; expand the time into date & time info
  if null = as-localtime time tm [return 2]
  
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
  result/day-of-week:       tm/wday + 1
  result/day-of-year:       tm/yday + 1
  
  ;; successful return
  0
]
 
