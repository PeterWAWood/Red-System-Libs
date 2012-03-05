Red/System [
  Purpose:     Win32 module for date-time library
  Author:      Peter W A Wood
  Version:     0.1.0
  Rights:      Copyright © 2012 Peter W A Wood. All rights reserved.
  License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#define PWAW-DT-MICROSECONDS 1000000
#define PWAW-DT-MILLISECONDS 1000

PWAW-DT-cpu-ticks!: alias struct! [
  ticks             [integer!]
  ticks-high        [integer!]
]
 
PWAW-DT-tm!: alias struct! [
  year-high         [byte!]
  year-low          [byte!]
  month-high        [byte!]
  month-low         [byte!] 
  day-of-week-high  [byte!]
  day-of-week-low   [byte!]
  day-high          [byte!]
  day-low           [byte!]
  hour-high         [byte!]
  hour-low          [byte!]
  minute-high       [byte!]
  minute-low        [byte!]
  seconds-high      [byte!]
  seconds-low       [byte!]
  milliseconds-high [byte!]
  milliseconds-low  [byte!]
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
	  get-cpu-ticks: "QueryPerformanceCounter" [
	    ticks       [PWAW-DT-cpu-ticks!]
	    return:     [integer!]
	  ]
	  get-local-time: "GetLocalTime" [
	    date-time   [PWAW-DT-tm!]
	  ]
	  get-time-zone: "GetTimeZoneInformation" [
	    time-zone   [PWAW-DT-time-zone!]
	    return:     [integer!]
	  ]
	]
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
  ;; local functions
  ms-word-to-int: func[
    high    [byte!]
    low     [byte!]
    return: [integer!]
  ][
    (as integer! low) * 256 + (as integer! high)
  ]
  
  ;; local variables
  localtime: declare PWAW-DT-tm!
  tz: declare PWAW-DT-time-zone!
  tm: declare PWAW-DT-tm!
  
  ;; get the machine time
  get-local-time tm
  
  ;; get time zone info
  tz-return: get-time-zone tz
  if any [
    tz-return < 0
    tz-return > 2
  ][
    return 3
  ]
 
  ;; fill the date structure
  result/year:              ms-word-to-int tm/year-high tm/year-low
  result/month:             ms-word-to-int tm/month-high tm/month-low
  result/day:               ms-word-to-int tm/day-high tm/day-low
  result/hour:              ms-word-to-int tm/hour-high tm/hour-low
  result/minutes:           ms-word-to-int tm/minute-high tm/minute-low
  result/seconds:           ms-word-to-int tm/seconds-high tm/seconds-low
  result/microseconds:      (ms-word-to-int tm/milliseconds-high tm/milliseconds-low) 
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
      either 0 = get-cpu-ticks start-tick [return 1] [return 0]
    ]
    
    2 [
      if 0 = get-cpu-ticks current-tick [return 1]
      if start-tick/ticks-high < 0 [return 2]
      if 0 <> PWAW-C-diff64 (as PWAW-C-int64! current-tick)
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
 
