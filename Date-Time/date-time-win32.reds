Red/System [
  Purpose:     Win32 module for date-time library
  Author:      Peter W A Wood
  Version:     0.1.0
  Rights:      Copyright © 2012 Peter W A Wood. All rights reserved.
  License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %../Int64/int64.reds
#define PWAW-DT-MICROSECONDS 1000000
#define PWAW-DT-MILLISECONDS 1000

PWAW-DT-cpu-ticks!: alias struct! [
  ticks             [integer!]
  ticks-high        [integer!]
]
 
PWAW-DT-tm!: alias struct! [
  year-low         [byte!]
  year-high          [byte!]
  month-low        [byte!]
  month-high         [byte!] 
  day-of-week-low  [byte!]
  day-of-week-high   [byte!]
  day-low          [byte!]
  day-high           [byte!]
  hour-low         [byte!]
  hour-high          [byte!]
  minute-low       [byte!]
  minute-high        [byte!]
  seconds-low      [byte!]
  seconds-high       [byte!]
  milliseconds-low [byte!]
  milliseconds-high  [byte!]
]
  
PWAW-DT-time-zone!: alias struct! [
  bias            [integer!]
  f1              [integer!]          ;;  Standard Name 32 x wchar
  f2              [integer!]
  f3              [integer!]
  f4              [integer!]
  f5              [integer!]
  f6              [integer!]
  f7              [integer!]
  f8              [integer!]
  f8              [integer!]
  f9              [integer!]
  f10             [integer!]
  f11             [integer!]
  f12             [integer!]
  f13             [integer!]
  f14             [integer!]
  f15             [integer!]
  f16             [integer!]
  g1              [integer!]          ;;  Standard Date 8 x int
  g2              [integer!]
  g3              [integer!]
  g4              [integer!]
  g5              [integer!]
  g6              [integer!]
  g7              [integer!]
  g8              [integer!]
  g8              [integer!]
  standard-bias   [integer!]
  h1              [integer!]          ;;  Daylight Name 32 x wchar
  h2              [integer!]
  h3              [integer!]
  h4              [integer!]
  h5              [integer!]
  h6              [integer!]
  h7              [integer!]
  h8              [integer!]
  h8              [integer!]
  h9              [integer!]
  h10             [integer!]
  h11             [integer!]
  h12             [integer!]
  h13             [integer!]
  h14             [integer!]
  h15             [integer!]
  h16             [integer!]
  i1              [integer!]          ;;  Daylight Date 8 x int
  i2              [integer!]
  i3              [integer!]
  i4              [integer!]
  i5              [integer!]
  i6              [integer!]
  i7              [integer!]
  i8              [integer!]
  i8              [integer!]
  daylight-bias   [integer!]
]

#import [
	"Kernel32.dll" stdcall [
	  PWAW-DT-get-cpu-ticks: "QueryPerformanceCounter" [
	    ticks       [PWAW-DT-cpu-ticks!]
	    return:     [integer!]
	  ]
	  PWAW-DT-get-local-time: "GetLocalTime" [
	    date-time   [PWAW-DT-tm!]
	  ]
	  PWAW-DT-get-time-zone: "GetTimeZoneInformation" [
	    time-zone   [PWAW-DT-time-zone!]
	    return:     [integer!]
	  ]
	  PWAW-DT-tm-to-filetime: "SystemTimeToFileTime" [
	    tm          [PWAW-DT-tm!]
	    ft          [PWAW-C-int64!]
	    return:     [integer!]
	  ]
	  get-last-error: "GetLastError" [
	    return:     [integer!]
	  ]
	]
]

PWAW-DT-date-difference: func [
;; returns the difference between two dates in seconds
  date1           [PWAW-DT-date!]
  date2           [PWAW-DT-date!]
  return:         [integer!]
  /local
  tm              [PWAW-DT-tm!]
  time1           [integer!]
  tz1             [integer!]
  time2           [integer!]
  tz2             [integer!]
  ft              [PWAW-C-int64!]
  time            [PWAW-C-int64!]
  ten-million [PWAW-C-int64!]
][
  ft: declare PWAW-C-int64!
  tm: declare PWAW-DT-tm!
  time: declare PWAW-C-int64!
  ten-million: declare PWAW-C-int64!
  ten-million/low: 10000000
  PWAW-DT-date-to-tm date1 tm
  PWAW-DT-tm-to-filetime tm ft lf
  PWAW-I64-div ft ten-million time
  time1: time/low
  tz1: (date1/tz-hours * 3600)
  either tz1 < 0 [
    tz1: tz1 - (date1/tz-minutes * 60)
  ][
    tz1: tz1 + (date1/tz-minutes * 60)    
  ]
  time1: time1 + tz1 
  PWAW-DT-date-to-tm date2 tm
  PWAW-DT-tm-to-filetime tm ft
  PWAW-I64-div ft ten-million time
  time2: time/low
  tz2: (date2/tz-hours * 3600)
  either tz2 < 0 [
    tz2: tz2 - (date2/tz-minutes * 60)
  ][
    tz2: tz2 + (date2/tz-minutes * 60)    
  ]
  time2: time2 + tz2
  time1 - time2
]

PWAW-DT-date-to-tm: func [
  date             [PWAW-DT-date!]
  tm               [PWAW-DT-tm!]
  /local
  microseconds     [integer!]  
][
  tm/year-high: as byte! (date/year / 256)
  tm/year-low: as byte! (date/year % 256)
  tm/month-high: as byte! (date/month / 256)
  tm/month-low: as byte! (date/month % 256)
  tm/day-high: as byte! (date/day / 256)         
  tm/day-low: as byte! (date/day % 256)
  tm/hour-high: as byte! (date/hour / 256)
  tm/hour-low: as byte! (date/hour % 256)
  tm/minute-high: as byte! (date/minutes / 256)
  tm/minute-low: as byte! (date/minutes % 256)
  tm/seconds-high: as byte! (date/seconds / 256)
  tm/seconds-low: as byte! (date/seconds % 256)
  microseconds: date/microseconds / 1000
  tm/milliseconds-high: as byte! (microseconds / 256)
  tm/milliseconds-low: as byte! (microseconds % 256)
]

PWAW-DT-ms-word-to-int: func [
  high      [byte!]
  low       [byte!]
  return:   [integer!]
][
  (as integer! high) * 256 + (as integer! low)
]

PWAW-DT-now: func [
;; fills the result structure argument with details of the current date/time
;; returns:
;;        0 - successful
;;        1 - cannot retrieve time from os
;;        2 - cannot convert the machine time
;;        3 - cannot retrieve time zone

  result      [PWAW-DT-date!]
  return:     [integer!]
  /local
  errcode     [integer!]
  tm          [PWAW-DT-tm!]
  tz          [PWAW-DT-time-zone!]
  tz-return   [integer!]
][
  
  ;; local variables
  localtime: declare PWAW-DT-tm!
  tz: declare PWAW-DT-time-zone!
  tm: declare PWAW-DT-tm!
  
  ;; get the machine time
  PWAW-DT-get-local-time tm
  
  ;; get time zone info
  tz-return: PWAW-DT-get-time-zone tz
  if any [
    tz-return < 0
    tz-return > 2
  ][
    return 3
  ]
 
  ;; fill the date structure
  result/year:              PWAW-DT-ms-word-to-int tm/year-high tm/year-low
  result/month:             PWAW-DT-ms-word-to-int tm/month-high tm/month-low
  result/day:               PWAW-DT-ms-word-to-int tm/day-high tm/day-low
  result/hour:              PWAW-DT-ms-word-to-int tm/hour-high tm/hour-low
  result/minutes:           PWAW-DT-ms-word-to-int tm/minute-high tm/minute-low
  result/seconds:           PWAW-DT-ms-word-to-int tm/seconds-high tm/seconds-low
  result/microseconds:      (PWAW-DT-ms-word-to-int tm/milliseconds-high tm/milliseconds-low) 
                            * 1000
  result/tz-hours:          -1 * (tz/bias / 60)
  result/tz-minutes:        -1 * (tz/bias % 60)

  ;; successful return
  0
]

PWAW-DT-timer: func [
  action        [integer!]
  start-tick    [PWAW-DT-cpu-ticks!]
  ticks-taken   [PWAW-DT-cpu-ticks!]
  return:       [integer!]
;;  action = 1 (Start timer)
;;    fills start-tick with the current cpu tick
;;  action = 2 (Read timer)
;;     calculates the time-taken from the supplied start-time
;;  return values:
;;        0 - successful
;;        1 - cannot retrieve time from os
;;        2 - no start tick supplied
;;        3 - start tick lower than current tick
;;        4 - difference to large for int 32
  /local
    current-tick  [PWAW-DT-cpu-ticks!]
][
  current-tick: declare PWAW-DT-cpu-ticks!
  
  switch action [
    1 [
      either 0 = PWAW-DT-get-cpu-ticks start-tick [return 1] [return 0]
    ]
    
    2 [
      if 0 = PWAW-DT-get-cpu-ticks current-tick [return 1]
      if start-tick/ticks-high < 0 [return 2]
      if 0 <> PWAW-I64-sub  (as PWAW-C-int64! current-tick)
                            (as PWAW-C-int64! start-tick)
                            (as PWAW-C-int64! ticks-taken) [
        return 3
      ]
      if any [                      ;; too big for integer! ?
        ticks-taken/ticks-high > 0
        ticks-taken/ticks < 0
      ][
        return 4                    ;; but still provide the actual difference
      ]
      
      return 0
    ] 
  ]
]

// debugging function
PWAW-DT-print-tm: func [
  tm    [PWAW-DT-tm!]
][
  print ["year " ((as integer! tm/year-high) * 256 + (as integer! tm/year-low)) lf]
  print ["month " ((as integer! tm/month-high) * 256 + (as integer! tm/month-low)) lf]
  print ["day-of-week " ((as integer! tm/day-of-week-high) * 256  + (as integer! tm/day-of-week-low)) lf]
  print ["day " ((as integer! tm/day-high) * 256  + (as integer! tm/day-low)) lf]
  print ["hour" ((as integer! tm/hour-high) * 256  + (as integer! tm/hour-low)) lf]
  print ["minute" ((as integer! tm/minute-high) * 256  + (as integer! tm/minute-low)) lf]
  print ["seconds" ((as integer! tm/seconds-high) * 256  + (as integer! tm/seconds-low)) lf] 
  print ["milliseconds " ((as integer! tm/milliseconds-high) * 256  + (as integer! tm/milliseconds-low)) lf]
]
 
