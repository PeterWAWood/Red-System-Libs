Red/System [
  Purpose:     "A basic date-time library"
  Author:      "Peter W A Wood"
  Version:     0.1.1
  Rights:      "Copyright © 2011 Peter W A Wood. All rights reserved."
  License:     "Distributed under the Boost Software License, Version 1.0."
	"See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt"
]

#include %../../Core/core.reds

#define PWAW-DT-start-timer [PWAW-DT-timer 1]
#define PWAW-DT-time-taken  [PWAW-DT-timer 2]

PWAW-DT-date!: alias struct! [
  year              [integer!]
  month             [integer!]
  day               [integer!]
  hour              [integer!]
  minutes           [integer!]
  seconds           [integer!]
  microseconds      [integer!]
  tz-hours          [integer!]
  tz-minutes        [integer!]
]

#switch OS [
  Windows  [#include %date-time-win32.reds]
	#default [#include %date-time-libc.reds]
]

PWAW-DT-load-date: func [
  {Loads the supplied date structure from a string}
  s               [c-string!]        {"dd-mmm-yyyy/hh:mm:ss+hh:mm"}
  d               [PWAW-DT-date!]    {an initialised PWAW-DT-date! struct in 
                                      which the date value will be placed}
  return:          [integer!]         {
  
       0 - successful
       1 - invalid day
       2 - invalid month
       3 - invalid year
       4 - invalid hour
       5 - invalid minutes
       6 - invalid seconds
       7 - invalid time zone
       8 - non-existant date
  }
   
  /local
    mth         [c-string!]
    i           [integer!]
][
    
  mth: "   "
  i: 0
    
  if any [
    0 <> PWAW-DT-store-int s 1 2 :i
    i < 1                          
    i > 31
  ][
    return 1
  ]
  d/day: i
  
  mth/1: s/4
  mth/2: s/5
  mth/3: s/6
  case [    
    any [
      PWAW-C-compare-strings mth "Jan"
      PWAW-C-compare-strings mth "jan"
    ][
      d/month: 1
    ]
    any [
      PWAW-C-compare-strings mth "Feb"
      PWAW-C-compare-strings mth "feb"
    ][
      d/month: 2
    ]
    any [
      PWAW-C-compare-strings mth "Mar"
      PWAW-C-compare-strings mth "mar"
    ][
      d/month: 3
    ]
    any [
      PWAW-C-compare-strings mth "Apr"
      PWAW-C-compare-strings mth "apr"
    ][
      d/month: 4
    ]
    any [
      PWAW-C-compare-strings mth "May"
      PWAW-C-compare-strings mth "may"
    ][
      d/month: 5
    ]
    any [
      PWAW-C-compare-strings mth "Jun"
      PWAW-C-compare-strings mth "jun"
    ][
      d/month: 6
    ]
    any [
      PWAW-C-compare-strings mth "Jul"
      PWAW-C-compare-strings mth "jul"
    ][
      d/month: 7
    ]
    any [
      PWAW-C-compare-strings mth "Aug"
      PWAW-C-compare-strings mth "aug"
    ][
      d/month: 8
    ]
    any [
      PWAW-C-compare-strings mth "Sep"
      PWAW-C-compare-strings mth "sep"
    ][
      d/month: 9
    ]
    any [
      PWAW-C-compare-strings mth "Oct"
      PWAW-C-compare-strings mth "oct"
    ][
      d/month: 10
    ]
    any [
      PWAW-C-compare-strings mth "Nov"
      PWAW-C-compare-strings mth "nov"
    ][
      d/month: 11
    ]
    any [
      PWAW-C-compare-strings mth "Dec"
      PWAW-C-compare-strings mth "dec"
    ][
      d/month: 12
    ]
    true [return 2]
  ]
  
  ;; check correct number of days in month
  switch d/month [
    2 [
      if d/day > 29 [return 8]
    ]
    4 6 9 11 [
      if d/day > 30 [return 8]
    ]
    default [
      true
    ]
  ]
    
  if any [
    0 <> PWAW-DT-store-int s 8 11 :i
    i < 0
  ][
    return 3
  ]
  d/year: i
  
  ;; leap year checking
  if d/month = 2 [
    if any [
      0 <> (d/year % 4)
      all [
        0 =  (d/year % 100)
        0 <> (d/year % 1000)
      ]
    ][
      if d/day > 28 [return 8]
    ]
  ]
    
  if any [
    0 <> PWAW-DT-store-int s 13 14 :i
    i > 23
    i < 0
  ][
    return 4
  ]
  d/hour: i
  
  if any [
    0 <> PWAW-DT-store-int s 16 17 :i
    i > 59
    i < 0
  ][
    return 5
  ]
  d/minutes: i
  
  if any [
    0 <> PWAW-DT-store-int s 19 20 :i
    i > 59
    i < 0
  ][
    return 6
  ]
  d/seconds: i
    
  if any [
    0 <> PWAW-DT-store-int s 21 23 :i
    i > 18
    i < -15
  ][
    return 7
  ]
  d/tz-hours: i
  
  if any [
    0 <> PWAW-DT-store-int s 25 26 :i
    all [
     i <> 0
     i <> 15
     i <> 30
     i <> 45
    ]
  ][
    return 7
  ]
  d/tz-minutes: i
  
  0
]

PWAW-DT-mold-date: func [
  {Provides a string representation of a date}
  d               [PWAW-DT-date!]         {the date}
  md              [c-string!]             
    {a string of at least 26 characters in
     which the molded date will be returned}
  return:         [integer!]
  {    0 - successful
       1 - provided string too short
       2 - invalid month
  }
  /local
  i             [integer!]
  pos           [integer!]
][
  if 26 > length? md [return 1]
  pos: 1
  PWAW-C-mold-int d/day md
  either d/day < 10 [md: md + 1] [md: md + 2]
  md/1: #"-"
  md: md + 1
  switch d/month [
    1       [PWAW-DT-push-month md #"J" #"a" #"n"]
    2       [PWAW-DT-push-month md #"F" #"e" #"b"]
    3       [PWAW-DT-push-month md #"M" #"a" #"r"]
    4       [PWAW-DT-push-month md #"A" #"p" #"r"]
    5       [PWAW-DT-push-month md #"M" #"a" #"y"]
    6       [PWAW-DT-push-month md #"J" #"u" #"n"]
    7       [PWAW-DT-push-month md #"J" #"u" #"l"]
    8       [PWAW-DT-push-month md #"A" #"u" #"g"]
    9       [PWAW-DT-push-month md #"S" #"e" #"p"]
    10      [PWAW-DT-push-month md #"O" #"c" #"t"]
    11      [PWAW-DT-push-month md #"N" #"o" #"v"]
    12      [PWAW-DT-push-month md #"D" #"e" #"c"]
    default [return 2]
  ]
  md: md + 3
  md/1: #"-"
  md: md + 1
  PWAW-C-mold-int d/year md 
  md: md + 4
  md/1: #"/"
  md: md + 1
  PWAW-DT-push-two-digits d/hour md
  md: md + 2
  md/1: #":"
  md: md + 1
  PWAW-DT-push-two-digits d/minutes md
  md: md + 2
  md/1: #":"
  md: md + 1
  PWAW-DT-push-two-digits d/seconds md
  md: md + 2
                                      ;; Note: a time zone with 0 hours and 
                                      ;; negative minutes would be incorrectly
                                      ;; molded. There is currently no such
                                      ;; time zone.
  either d/tz-hours >= 0 [
    md/1: #"+"
    md: md + 1
  ][
    md/1: #"v"                        ;; write over the null-byte added by
                                      ;;  mold-int
  ]
  PWAW-C-mold-int d/tz-hours md
  case [
    d/tz-hours < -9 [md: md + 3]
    d/tz-hours < 0  [md: md + 2]
    d/tz-hours > 10 [md: md + 2]
    true            [md: md + 1]
  ]
  md/1: #":"
  md: md + 1
  PWAW-DT-push-two-digits d/tz-minutes md
  
  0
]

PWAW-DT-push-month: func [
  {private}
  s [c-string!]
  a [byte!]
  b [byte!]
  c [byte!]
][
  s/1: a
  s/2: b
  s/3: c
]

PWAW-DT-push-two-digits: func [
  {private}
  i [integer!]
  s [c-string!]
][
  if i < 10 [
    s/1: #"0"
    s: s + 1
  ]
  PWAW-C-mold-int i s
]

PWAW-DT-store-int: func [
  {private}
  s           [c-string!]
  start       [integer!]
  end         [integer!]
  pi          [pointer! [integer!]]
  return:     [integer!]     
][
  either any [
    not PWAW-C-str-int? [s start end] 
    0 <> PWAW-C-load-int [s pi start end]
  ][1][0]
]